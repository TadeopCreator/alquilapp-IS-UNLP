class RegistrationsController < Devise::RegistrationsController
    def new
      super
    end
  
    def create
      super
      usuario = Usuario.create!(:name => params[:name], :lastname => params[:lastname], 
                :dni => params[:dni], :contact => params[:phone])
      puts('Usuario creado: ID: ', usuario[:id])
      
      # Actuliza el User del devise con el id_rol correspondiente
      @user = User.last
      @user.update_attribute(:id_rol, usuario[:id])
    end
    
    def update
      super
    end
end 