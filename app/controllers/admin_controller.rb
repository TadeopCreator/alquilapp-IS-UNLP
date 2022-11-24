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
    
    if (@auto[:alquilado])
      flash[:notice] = 'El vehículo no puede ser eliminado porque esta siendo utilizado'
      redirect_to edit_auto_path(@auto.id)
    else
      attributes = {}
      attributes[:borrado] = true

      @auto.update(attributes)

      # Redireccionamiento y mensaje
      flash[:notice] = 'Vehículo eliminado exitosamente'
      redirect_to admin_vehiculos_path
    end
  end

  def eliminar_supervisor
    unless current_user.admin?
      redirect_to new_user_session_path
    end

    # Tomo el id ddel auto a eliminar
    supervisor_ID = params[:format]

    # Tomo al auto de acuerdo al supervisor_ID del Supervisor
    @supervisor = Supervisor.find(supervisor_ID.to_s)

    attributes = {}
    attributes[:borrado] = true

    # Marco el Supervisor como borrado
    @supervisor.update(attributes)

    sql = "SELECT * FROM users WHERE id_rol='" + supervisor_ID.to_s + "'"
    records_array = ActiveRecord::Base.connection.execute(sql)
    id_user = records_array[0]["id"]

    # Tomo al user de acuerdo al user_ID del User
    @user = User.find(id_user.to_s)

    # Destruye al user
    @user.destroy

    # Redireccionamiento y mensaje
    flash[:notice] = 'Supervisor eliminado exitosamente'
    redirect_to admin_supervisores_path
  end

  def add_supervisor
    unless current_user.admin?
      redirect_to new_user_session_path
      return
    end
    #generated_password = Devise.friendly_token.first(8)
      admin = Admin.create!(:name => "Nombre",:lastname => "Apellido",:dni => "123123123123",:phone => "002112312312")        
      
      # Crea el user del devise con el rol de admin

      @user = User.create!(:email => 'admin@admin.com', :password => 'admin123', :role => :admin)
      
      @user.update_attribute(:id_rol, admin[:id])


      #admin = Amin.create!(:name => params[:name],:lastname => params[:lastn],:dni => params[:dni],:mail => params[:email],:phone => params[:phone])
      puts('Admin added') #admin2@admin asdasd
  end
end
