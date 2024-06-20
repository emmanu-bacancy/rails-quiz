require 'rails_helper'

RSpec.describe 'Listing people', type: :feature do
  before do
    Person.create(
      name: 'Foo Bar',
      phone_number: '123',
      email: 'john.doe@example.com',
      companies: [ Company.create(name: 'Sony') ]
    )
  end

  scenario 'with valid users' do
    visit people_path

    aggregate_failures do
      expect(page).to have_content('Foo Bar')
      expect(page).to have_content('john.doe@example.com')
      expect(page).to have_content('Sony')
    end
  end

  scenario 'New person', type: :feature do
    visit new_person_path

    expect(page).to have_field :person_name
  end
end
