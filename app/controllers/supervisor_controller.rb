class SupervisorController < ApplicationController


  def aceptar
    attributes = {}
    attributes[:send_license] = 0
    attributes[:enable] = true
    @usuario = Usuario.find(params[:id])
    @usuario.update(attributes)
    redirect_to :supervisors
  end

  def rechazar
    attributes = {}
    attributes[:send_license] = 0
    attributes[:enable] = false
    @usuario = Usuario.find(params[:id])
    @usuario.update(attributes)
    redirect_to :supervisors
  end
  
  def dashboard
    @autos = Auto.all.order(created_at: :desc) #Se puede alterar, pero en el inicio se ve la lista de autos
  end
  
end
