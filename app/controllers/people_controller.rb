class PeopleController < ApplicationController
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

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number, :email_confirmation, company_ids: [])
  end
end
