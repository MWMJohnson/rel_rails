Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/new", to: "shelters#new"
  post "/shelters", to: "shelters#create"
  get "/shelters/:id", to: "shelters#show"
  get "/shelters/:id/edit", to: "shelters#edit"
  patch "/shelters/:id", to: "shelters#update"
  
  get "/pets", to: "pets#index", as: "pets"
  get "/pets/:id", to: "pets#show"

  
  get "/shelters/:id/pets", to: "pets#index"
end
