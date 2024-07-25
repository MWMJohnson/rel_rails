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
  get "/pets/:id/edit", to: "pets#edit"
  patch "/pets/:id", to: "pets#update"

  
  get "/shelters/:id/pets", to: "pets#index", as: "shelter_pets"
  get "/shelters/:id/pets/new", to: "pets#new"
  post "/shelters/:id/pets", to: "pets#create"
end
