class RegistrationsController < Devise::RegistrationsController
    def new
      super
    end
  
    def create
      usuario = Usuario.create!(:name => params[:name], :lastname => params[:lastname], 
                :dni => params[:dni], :contact => params[:phone])
      puts('Creado!!!!!!!!!!!!!!!!!!!!!!!!!!!!', usuario[:id])
      super
      #redirect_to new_admin_path, params => 'hola' and return
    end
  
    def update
      super
    end
end 