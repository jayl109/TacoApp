Rails.application.routes.draw do
  devise_for :users
  root  to: "tacos#index"
  get "/tacos/new/", to: "tacos#new", as: "new_taco"

  post "/tacos/create/", to: "tacos#create", as: "create_taco"
  get '/tacos/delete/:id', to: "tacos#delete", as:"delete_taco"
  get '/tacos/view/:id', to: "tacos#view", as:"view_taco"
  get '/tacos/random', to: "tacos#random", as:"random_taco"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
