class FinalizarAlquilerController < ApplicationController
  def finalizar
    @auto = Auto.find(params[:auto].to_s)
    @usuario = Usuario.find(params[:usuario].to_s)

    # Setea el auto como no alquilado
    alquilar = {}
    alquilar[:alquilado] = false
    @auto.update(alquilar)

    # Actualizo para que el usuario aparezca como que no esta alquilando
    alquilando = {}
    alquilando[:alquilando] = false
    @usuario.update(alquilando)

    @historial = Historial.where(id_usr: @usuario.id).last

    multa = false
    tiempo_multa = 1
    total = ((@historial.precio * @historial.tiempoAlquilado)+(@historial.pextra * @historial.tiempo_extension))
    fin_fecha = DateTime.now - 3.hours
    if (@historial.fin < fin_fecha)
      multa = true
      tiempo_multa=(((-(@historial.fin.to_datetime - fin_fecha)*24*60).to_i)/@historial.tiempo_multa) #Calcula la diferencia en minutos y lo divide por el intervalo en que se cobra la multa
      total = total +(@historial.precio_multa * tiempo_multa).round(2)
    end
    
    @historial.update(fin: fin_fecha, multa: multa, total:total, tiempo_multa: tiempo_multa)


    # Actualiza el saldo de la wallet cobrando el alquiler
    @wallet = Wallet.find(@usuario.id_wallet)
    saldo = @wallet.saldo - total
    @wallet.update(saldo:saldo)

    flash[:notice] = "Alquiler finalizado"
    redirect_to historials_receipt_path
  end
end
