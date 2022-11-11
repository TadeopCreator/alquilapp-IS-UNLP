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
  
  def dashboard
    @autos = Auto.all.order(created_at: :desc) #Se puede alterar, pero en el inicio se ve la lista de autos
  end
  
end
