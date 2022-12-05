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
    total= ((@historial.precio * @historial.tiempoAlquilado)+(@historial.pextra * @historial.tiempo_extension))
    fin_fecha = DateTime.now - 3.hours
    if (@historial.fin < fin_fecha)
      multa = true
      diff_m= fin_fecha.min - (Time.now - (@historial.tiempoAlquilado + @historial.tiempo_extension).hours).min
      diff_h= (fin_fecha.hour - (Time.now - (@historial.tiempoAlquilado + @historial.tiempo_extension).hours).hour)*60
      total= total +(@historial.precio_multa * ((diff_m+diff_h)/@historial.precio_multa).to_i)
    end
    
    @historial.update(fin: fin_fecha, multa: multa, total:total)


    # Actualiza el saldo de la wallet cobrando el alquiler
    @wallet = Wallet.find(@usuario.id_wallet)
    saldo = @wallet.saldo - total
    @wallet.update(saldo:saldo)

    flash[:notice] = "Alquiler finalizado"
    redirect_to historials_receipt_path
  end
end
