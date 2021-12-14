Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/users/login", to: "users#login"
  get "/users/me", to: "users#me"

  resources :orders, :only => [:create, :update, :show, :destroy, :index]
end
