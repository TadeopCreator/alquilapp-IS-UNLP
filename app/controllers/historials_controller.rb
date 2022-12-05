class HistorialsController < ApplicationController

    def create
        fallo = false
        
        @auto = Auto.find(params[:id_auto].to_i)

        user_ID = current_user.id
        sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol = records_array[0]["id_rol"]

        @usuario = Usuario.find(id_rol.to_s)
        @global = Global.last
        @historial = Historial.new
        @saldo = Wallet.find(@usuario[:id_wallet])
        @costo = @global.monto_auto * params[:tiempoAlquilado].to_i

        if  (params[:tiempoAlquilado].to_i < 1) || (params[:tiempoAlquilado].to_i > 24)            
            flash[:notice] = "Solo puede alquilar el vehiculo entre 1-24 horas"
            fallo = true
        end

        if (@saldo.saldo < @costo)     
            faltante = @costo - @saldo.saldo     
            flash[:notice] = "Saldo insuficiente, necesita $#{faltante} extra"
            fallo= true
        end

        if fallo            
            redirect_to @auto
        else
            # Creo una nuevo fila de historial de alquileres
            attributes = {}
            attributes[:id_usr] = @usuario.id
            attributes[:id_auto] = @auto.id
            attributes[:tiempoAlquilado] = params[:tiempoAlquilado]
            attributes[:precio] = @global.monto_auto
            attributes[:pextra] = @global.monto_extension
            attributes[:precio_multa] = @global.monto_multa
            attributes[:multa] = false
            attributes[:tiempo_extension] = 0
            attributes[:fin] = Time.now + params[:tiempoAlquilado].to_i.hours - 3.hours
            @historial = Historial.new(attributes)
            
            # Si esta alquilando de verdad (post modal)
            if (params[:alquilar] != nil)
                puts("ALQUILANDO: ", params)
                respond_to do |format|
                    if @historial.save
                        # Setea el auto como alquilado
                        alquilar = {}
                        alquilar[:alquilado] = true
                        @auto.update(alquilar)
    
                        # Actualizo para que el usuario aparezca como que esta alquilando
                        alquilando = {}
                        alquilando[:alquilando] = true
                        @usuario.update(alquilando)
    
                        format.html { redirect_to autos_url, notice: "Su alquiler ha comenzado" }
                        format.json { render :show, status: :created, location: @historial }
                    else
                        render :new
                    end
                end
            else
                @param = {}
                total = @global.monto_auto * params[:tiempoAlquilado].to_i
                @param[:precio_total] = total.to_s
                @param[:tiempo_alquilado] = params[:tiempoAlquilado]
                @param[:alquilar_ahora_si] = true
                redirect_to auto_path(@auto, @param)   
            end         
        end
    end


  def receipt
    unless (user_signed_in? && current_user.user?)
      redirect_to new_user_session_path
    end
    user_ID = current_user.id
    sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
    records_array = ActiveRecord::Base.connection.execute(sql)
    id_rol=records_array[0]["id_rol"]
    @usuario = Usuario.find(id_rol.to_s)
    @historial = Historial.where(id_usr:@usuario.id)
    puts("SI PASA POR EL CONTROLADOR")
  end
  
end