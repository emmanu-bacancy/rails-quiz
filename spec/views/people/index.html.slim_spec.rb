require 'rails_helper'

RSpec.describe "people/index", type: :view do
  before(:each) do
    Person.create(name: 'John Doe', phone_number: '123', email: 'john.doe@example.com', companies: [ Company.create(name: 'Sony') ])

    assign(:people, Person.all.page(params[:page]).per(10))
  end

  it "renders a list of people" do
    render
    assert_select "tr>td", text: "John Doe".to_s, count: 1
    assert_select "tr>td", text: "123".to_s, count: 1
    assert_select "tr>td", text: "john.doe@example.com".to_s, count: 1
    assert_select "tr>td", text: "Sony".to_s, count: 1
  end
end
