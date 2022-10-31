class RegistrationsController < Devise::RegistrationsController
    def new
      super
    end
  
    def create
      admin = Admin.create!(:name => params[:name],:lastname => params[:lastn],:dni => params[:dni],:mail => params[:email],:phone => params[:phone])
      puts('Creado!!!!!!!!!!!!!!!!!!!!!!!!!!!!', admin.name)
      super
      #redirect_to new_admin_path, params => 'hola' and return            
    end
  
    def update
      super
    end
end 