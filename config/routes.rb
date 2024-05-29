Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "destinations#home"

  get "/destinations", to: "destinations#index"
  get "/select", to: "destinations#random"
  get "/destinations/:id", to: "destinations#show", as: "destination"
end
