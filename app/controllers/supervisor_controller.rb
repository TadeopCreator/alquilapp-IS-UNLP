class SupervisorController < ApplicationController

  def licencias
    unless current_user.supervisor?
      redirect_to new_user_session_path
    end
  end

  def aceptar
    attributes = {}
    attributes[:send_license] = 0
    attributes[:enable] = true
    @usuario = Usuario.find(params[:id])
    @usuario.update(attributes)

    # Envio de mensaje
    title = "Licencia aceptada"
    description = "Enhorabuena su licencia de conducir ha sido autenticada y ya puede alquilar vehículos."
    # message_type = 4 -> Mensaje de licencia aceptada
    user = Message.create(title: title, description: description, message_type: 4, dest: params[:id])
    redirect_to :supervisors, notice: "Se ha aceptado la validación con éxito"
  end

  def rechazar
    attributes = {}
    attributes[:send_license] = 0
    attributes[:enable] = false
    @usuario = Usuario.find(params[:id])
    @usuario.update(attributes)
    # Envio de mensaje
    title = "Licencia rechazada"
    description = "Lamentamos informarle que su licencia de conducir ha sido rechazada manualmente, será necesario que revise y actualice los datos correspondientes desde el Editor de perfil."
    # message_type = 5 -> Mensaje de licencia rechazada
    user = Message.create(title: title, description: description, message_type: 5, dest: params[:id])
    redirect_to :supervisors, notice: "Se ha rechazado la validación con éxito"
  end

  def habilitar
    attributes = {}
    attributes[:habilitado] = true
    @auto = Auto.find(params[:id])
    @auto.update(attributes)
    redirect_to :supervisors
  end

  def deshabilitar
    attributes = {}
    attributes[:habilitado] = false
    @auto = Auto.find(params[:id])
    @auto.update(attributes)
    redirect_to :supervisors
  end

  def bloqueo
    attributes = {}
    @user = User.where(role:"user").where(id_rol: params[:id]).first
    @usuario = Usuario.find(params[:id])
    if @usuario.alquilando
      flash[:notice] = "No se ha podido bloquear al usuario porque se encuentra alquilando en este momento."
    else
      if @user.access_locked?
        @user.unlock_access!
        attributes[:lock] = false
      else
        @user.lock_access!
        attributes[:lock] = true
      end
      @usuario.update(attributes)
    end
    redirect_to :supervisors
  end

  
  def dashboard
    @autos = Auto.all.order(created_at: :desc) #Se puede alterar, pero en el inicio se ve la lista de autos
  end
  
end
