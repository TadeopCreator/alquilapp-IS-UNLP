class RegistrationsController < Devise::RegistrationsController
    def new
      super
    end
  
    def create
      puts(params.inspect)
      usuario = Usuario.create!(:name => params[:name], :lastname => params[:lastname], :dni => params[:dni], :email => params[:user][:email], :phone => params[:phone])
      #puts('Creado!!!!!!!!!!!!!!!!!!!!!!!!!!!!', admin.name)
      super
      #redirect_to new_admin_path, params => 'hola' and return            
    end
  
    def update
      super
    end
end 