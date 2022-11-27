class FinalizarAlquilerController < ApplicationController
  def finalizar
    @auto = Auto.find(params[:auto].to_s)
    @usuario = Usuario.find(params[:usuario].to_s)

    # Setea el auto como alquilado
    alquilar = {}
    alquilar[:alquilado] = false
    @auto.update(alquilar)

    # Actualizo para que el usuario aparezca como que esta alquilando
    alquilando = {}
    alquilando[:alquilando] = false
    @usuario.update(alquilando)

    @historial = Historial.where(id_usr: @usuario.id).last
    puts("Historial: ", @historial)

    fin_fecha = Time.now - 3.hours

    @historial.update(fin: fin_fecha)

    flash[:notice] = "Alquiler finalizado"
    redirect_to autos_path
  end
end
