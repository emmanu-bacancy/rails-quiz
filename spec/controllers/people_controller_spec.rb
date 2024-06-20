require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  subject { response }
  describe 'GET index' do
    before { get :index }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'GET new' do
    before { get :new }

    it { is_expected.to have_http_status(:ok) }
  end

  describe 'POST create with valid params' do
    it 'Creates a record' do
      expect { post :create, params: { person: { name: 'John Doe', phone_number: '123', email: 'john.doe@example.com' } } }.to change { Person.count }.by(1)
    end

    it 'has status found' do
      expect(post :create, params: { person: { name: 'John Doe', phone_number: '123', email: 'john.doe@example.com' } }).to have_http_status(:found)
    end
  end

  describe 'POST create with invalid params' do
    before do
      post :create, params: { person: { phone_number: '123', email: 'John Doe' } }
    end

    it { is_expected.to have_http_status(:unprocessable_entity) }
  end
end
