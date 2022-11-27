class HistorialsController < ApplicationController

    def create
        fallo = false
        @auto = Auto.find(params[:id_auto].to_i)
        user_ID = current_user.id
        sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
        records_array=ActiveRecord::Base.connection.execute(sql)
        id_rol=records_array[0]["id_rol"]
        @usuario = Usuario.find(id_rol.to_s)
        @global = Global.last
        @historial = Historial.new
        @saldo = Wallet.find(@usuario[:id_wallet])

        if  (params[:tiempoAlquilado].to_i < 1) || (params[:tiempoAlquilado].to_i > 24)            
            flash[:notice] = "Solo puede alquilar el vehiculo entre 1-24 horas"
            fallo = true
        end
        if (@saldo.saldo < (@global.monto_auto * params[:tiempoAlquilado].to_i))          
            flash[:notice] = "Saldo insuficiente"
            fallo= true
        end
        if fallo
            redirect_to @auto
        else

            attributes = {}
            attributes[:id_usr] = @usuario.id
            attributes[:id_auto] = @auto.id
            attributes[:tiempoAlquilado] = params[:tiempoAlquilado]
            attributes[:precio] = @global.monto_auto
            attributes[:multa] = false
            attributes[:fin] = Time.now + params[:tiempoAlquilado].to_i.hours
            @historial = Historial.new(attributes)
            respond_to do |format|
                if @historial.save
                    wallet = {}
                    wallet[:saldo] = @saldo.saldo - (@global.monto_auto * params[:tiempoAlquilado].to_i)
                    @saldo.update(wallet)
                    alquilar = {}
                    alquilar[:alquilado] = true
                    @auto.update(alquilar)
                    format.html { redirect_to autos_url, notice: "Su alquiler ha comenzado" }
                    format.json { render :show, status: :created, location: @historial }
                else
                    render :new
                end
            end
        end
    end
end