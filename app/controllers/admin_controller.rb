class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: [:admin_dashboard, :admin_supervisores]

  def is_admin?
    unless current_user.admin?
      flash.alert = "Sorry, you don't have permissions to perform this action."
      redirect_to root_path
    end
  end

  def dashboard
    unless current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def supervisores
    unless current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def vehiculos
    unless current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def eliminar_vehiculo
    unless current_user.admin?
      redirect_to new_user_session_path
    end

    # Tomo el id ddel auto a eliminar
    auto_ID = params[:format]

    # Tomo al auto de acuerdo al auto_ID del Auto
    @auto = Auto.find(auto_ID.to_s)

    attributes = {}
    attributes[:borrado] = true

    @auto.update(attributes)   

    # Redireccionamiento y mensaje
    flash[:notice] = 'El vehículo ha sido actualizado correctamente'
    redirect_to admin_vehiculos_path
  end

  def add_supervisor
    unless current_user.admin?
      redirect_to new_user_session_path
      return
    end
    #generated_password = Devise.friendly_token.first(8)
      admin = Admin.create!(:name => "Nombre",:lastname => "Apellido",:dni => "123123123123",:phone => "002112312312")        
      
      # Crea el user del devise con el rol de admin

      @user = User.create!(:email => 'admin2@admin.com', :password => 'asdasd', :role => :admin)
      
      @user.update_attribute(:id_rol, admin[:id])


      #admin = Amin.create!(:name => params[:name],:lastname => params[:lastn],:dni => params[:dni],:mail => params[:email],:phone => params[:phone])
      puts('Admin added') #admin2@admin asdasd
  end
end
