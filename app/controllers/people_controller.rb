class PeopleController < ApplicationController

  def index
    @people = Person.all
  end

  def new
    @person = Person.new
  end

  def create
    Person.create!(person_attributes)
    
    redirect_to people_path, notice: 'Successfully created entry'
  end

  private

  def person_attributes
    params.require(:person).permit(:name, :email, :phone_number)
  end

end

