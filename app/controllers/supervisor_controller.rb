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
    redirect_to :supervisors, notice: "Se ha aceptado la validación con éxito"
  end

  def rechazar
    attributes = {}
    attributes[:send_license] = 0
    attributes[:enable] = false
    @usuario = Usuario.find(params[:id])
    @usuario.update(attributes)
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
    if @user.access_locked?
      @user.unlock_access!
      attributes[:lock] = false
    else
      @user.lock_access!
      attributes[:lock] = true
    end
    @usuario.update(attributes)
    redirect_to :supervisors
  end

  
  def dashboard
    @autos = Auto.all.order(created_at: :desc) #Se puede alterar, pero en el inicio se ve la lista de autos
  end
  
end
