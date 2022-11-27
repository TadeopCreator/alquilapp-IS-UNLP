Rails.application.routes.draw do
  resources :usuarios
  resources :reports
  resources :supervisors
  resources :autos
  resources :globals
  get 'wallet/show'
  get 'wallet/edit'
  post 'wallet/edit'

  post '/autos/:id', to: 'historials#create'
  
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'users/sessions'}
  
  get 'supervisor/aceptar'
  get 'supervisor/rechazar'
  get 'supervisor/habilitar'
  get 'supervisor/deshabilitar'
  get 'supervisors/licencias'
  get 'supervisor/licencias'  
  get 'admin/dashboard'
  get 'admin/supervisores'
  get 'admin/vehiculos'
  get 'admin/precios'
  get 'admin/add_supervisor'
  get 'terminos_condiciones/show'

  get 'admin/eliminar_vehiculo'
  get 'admin/eliminar_supervisor'

  # rails routes to seee all the routes in the app
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
