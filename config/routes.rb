Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/shelters", to: "shelters#index"
  get "/shelters/:id", to: "shelters#show"

  get "/pets", to: "pets#index"
  get "/pets/:id", to: "pets#show"
  
end
