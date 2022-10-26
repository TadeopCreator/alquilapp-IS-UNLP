Rails.application.routes.draw do
  resources :administrators
  resources :supervisors
  #get 'home/index'

  # rails routes to seee all the routes in the app
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
