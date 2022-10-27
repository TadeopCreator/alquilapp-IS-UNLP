class RegistrationsController < Devise::RegistrationsController
    def new
      super
    end
  
    def create
      puts('Nombre: ', params[:name])
      admin = Admin.create!(:name => params[:name])
      puts('Creado!!!!!!!!!!!!!!!!!!!!!!!!!!!!', admin.name)
      super
      #redirect_to new_admin_path, params => 'hola' and return            
    end
  
    def update
      super
    end
end 