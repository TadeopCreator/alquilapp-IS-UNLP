Rails.application.routes.draw do
  resources :messages
  resources :usuarios
  resources :reports
  resources :supervisors
  resources :autos
  resources :globals
  get 'wallet/show'
  get 'wallet/edit'
  post 'wallet/edit'

  get 'historials/receipt'
  get 'historials/recibo'
  get 'historials/auto'
  get 'historials/multa'
  get 'historials/extender'
  post 'historials/extender', to: 'historials#confirmar_extender'
  
  post '/autos/:id', to: 'historials#create'
  post '/historials/multa', to: 'historials#cobrar'
  
  devise_for :users, controllers: {registrations: 'registrations', sessions: 'users/sessions'}
  
  get 'supervisor/aceptar'
  get 'supervisor/rechazar'
  get 'supervisor/habilitar'
  get 'supervisor/deshabilitar'
  get 'supervisors/licencias'
  get 'supervisor/licencias'  
  get 'supervisor/bloqueo'
  
  get 'admin/dashboard'
  get 'admin/supervisores'
  get 'admin/vehiculos'
  get 'admin/precios'
  get 'admin/users'
  get 'admin/add_supervisor'
  get 'admin/habilitar'
  get 'admin/deshabilitar'
  get 'terminos_condiciones/show'
  
  get 'admin/eliminar_vehiculo'
  get 'admin/eliminar_supervisor'
  get 'admin/eliminar_usuario'
  
  get 'finalizar_alquiler/finalizar'
  
  # rails routes to seee all the routes in the app
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
