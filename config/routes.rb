Rails.application.routes.draw do
  resources :usuarios
  resources :reports
  resources :supervisors
  resources :autos
  
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'users/sessions'}
  
  get 'admin/dashboard'
  get 'admin/supervisores'
  get 'admin/vehiculos'
  get 'admin/add_supervisor'
  get 'terminos_condiciones/show'

  # rails routes to seee all the routes in the app
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
