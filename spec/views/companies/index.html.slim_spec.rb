require 'rails_helper'

RSpec.describe "companies/index", type: :view do
  before(:each) do
    Company.create([ { name: 'Sony' }, { name: 'LG' } ])

    assign(:companies, Company.all.page(params[:page]).per(10))
  end

  it "renders a list of companies" do
    render
    assert_select "tr>td", text: "Sony".to_s, count: 1
    assert_select "tr>td", text: "LG".to_s, count: 1
  end
end
