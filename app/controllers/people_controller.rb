class PeopleController < ApplicationController
  before_action :set_companies, only: %i[new create]

  def index
    @people = Person.includes(:companies).page(params[:page]).per(10)
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_attributes)

    if @person.save
      redirect_to people_path, notice: "Successfully created entry"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_companies
    @companies = Company.select(:id, :name)
  end

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number, :email_confirmation, company_ids: [])
  end
end
