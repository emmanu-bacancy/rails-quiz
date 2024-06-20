Rails.application.routes.draw do
  resources :companies, except: [ :destroy ]

  resources :people, only: [ :index, :new, :create ]
  root to: "people#index"
end
