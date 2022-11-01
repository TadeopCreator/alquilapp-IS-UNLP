class SupervisorController < ApplicationController

  def dashboard
    @autos = Auto.all.order(created_at: :desc) #Se puede alterar, pero en el inicio se ve la lista de autos
  end
  
end
