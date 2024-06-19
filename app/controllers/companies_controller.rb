class CompaniesController < ApplicationController
  before_action :set_company, only: %i[ show edit update destroy ]
  http_basic_authenticate_with name: "dhh", password: "secret", only: :create_companies
  protect_from_forgery with: :null_session, only: :create_companies # Disable CSRF protection for JSON requests

  # GET /companies or /companies.json
  def index
    @companies = Company.includes(:people)

    if params[:search].present?
      search_term = params[:search].downcase
      @companies = @companies.where("LOWER(name) LIKE ?", "%#{search_term}%")
    end

    @companies = @companies.page(params[:page]).per(10)
  end

  # GET /companies/1 or /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to companies_url, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_companies
    companies_params = params.require(:companies)

    created_companies = []
    companies_params.each do |company_param|
      company = Company.new(company_params(company_param))
      if company.save
        created_companies << company
      else
        render json: { error: company.errors.full_messages }, status: :unprocessable_entity
        return
      end
    end

    render json: created_companies, status: :created
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to companies_url, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params(company_param = nil)
      if company_param
        company_param.permit(:name)
      else
        params.require(:company).permit(:name, person_ids: [])
      end
    end
end
