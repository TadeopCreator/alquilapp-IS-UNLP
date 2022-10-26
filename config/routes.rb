Rails.application.routes.draw do
  devise_for :users

  get 'admin/dashboard'
  get 'admin/add_supervisor'
  get 'supervisor/dashboard'
  
  # rails routes to seee all the routes in the app
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
