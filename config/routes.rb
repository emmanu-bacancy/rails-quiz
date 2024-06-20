Rails.application.routes.draw do
  resources :companies, except: [ :destroy ]
  post "create_companies", to: "companies#create_companies"

  resources :people, only: [ :index, :new, :create ]
  root to: "people#index"
end
