class HistorialsController < ApplicationController
    before_action :authenticate_user!

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
            attributes[:tiempo_multa] = @global.tiempo_multa
            attributes[:fin] = Time.now + params[:tiempoAlquilado].to_i.hours - 3.hours
            @historial = Historial.new(attributes)
            
            # Si esta alquilando de verdad (post modal)
            if (params[:alquilar] != nil)
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
    @historial = Historial.where(id_usr:@usuario.id).order(id: :DESC)
  end

  def recibo
    unless (user_signed_in? && current_user.user?)
      redirect_to new_user_session_path
    end
    @historial = Historial.find(params[:id])
    @user = Usuario.find(@historial.id_usr)
    @auto = Auto.find(@historial.id_auto)
  end
  
  def auto
    unless (user_signed_in? && current_user.supervisor?)
      redirect_to new_user_session_path
    end
    @historial = Historial.where(id_auto:params[:id]).order(id: :DESC)
  end

  def multa
    unless (user_signed_in? && current_user.supervisor?)
      redirect_to new_user_session_path
    end
    @user = Usuario.find(params[:id_usr])
    @wallet = Wallet.find(@user.id_wallet)
    @historial = Historial.find(params[:id_hist])
  end

  def cobrar
    unless (user_signed_in? && current_user.supervisor?)
      redirect_to new_user_session_path
    end

    if (params[:amount].to_i < 0)
      flash[:notice] = "Por favor ingrese un valor que no sea menor a 0"
      redirect_to "/historials/multa?id_hist="+params[:id_hist].to_s+"&id_usr="+params[:id_usr].to_s
    else
      @historial = Historial.find(params[:id_hist])
      @wallet = Wallet.find(params[:id_wallet])
      @wallet.update(saldo:(@wallet.saldo-params[:amount].to_f))
      motivo= "Varios"
      if params[:motive].to_s == "Oil"
        motivo="No relleno tanque"
      else
        if params[:motive].to_s == "Broke"
          motivo="Vehiculo Roto"
        else
          if params[:motive].to_s == "Left"
            motivo="Vehiculo fuera de La Plata"
          end
        end
      end
      hisupt = {}
      hisupt[:multa] = 1
      hisupt[:motive] = motivo
      hisupt[:precio_multa] = @historial.precio_multa+(params[:amount].to_f)
      hisupt[:total] = @historial.total+params[:amount].to_f
      @historial.update(hisupt)
      redirect_to historials_auto_path(:id => @historial.id_auto)
    end
  end

  def extender
    @historial = Historial.find(params[:id].to_i)
    @usuario = Usuario.find(params[:usr].to_i)
  end

  def confirmar_extender
    fallo = false

    @historial = Historial.find(params[:id].to_i)
    @usuario = Usuario.find(params[:usr].to_i)
    @saldo = Wallet.find(@usuario[:id_wallet])
    @costo = @historial.pextra * params[:tiempo_extension].to_i

    if  (params[:tiempo_extension].to_i < 1) || (params[:tiempo_extension].to_i + @historial.tiempo_extension + @historial.tiempo_extension > 24)            
        flash[:notice] = "Solo puede alquilar el vehiculo entre 1-#{params[:rest].to_i} horas"
        fallo = true
    end

    if (@saldo.saldo < @costo)     
        faltante = @costo - @saldo.saldo     
        flash[:notice] = "Saldo insuficiente, necesita $#{faltante} extra"
        fallo= true
    end

    if fallo            
        redirect_to historials_extender_path(:id => @historial.id, :usr => @usuario.id)
    else        
      # Si esta alquilando de verdad (post modal)
      if (params[:alquilar] != nil)
        respond_to do |format|
          # Creo una nuevo fila de historial de alquileres
          attributes = {}
          attributes[:tiempo_extension] = params[:tiempo_extension].to_i + @historial.tiempo_extension
          attributes[:fin] = @historial.fin + params[:tiempo_extension].to_i.hours
          @historial = Historial.update(attributes)

          format.html { redirect_to autos_url, notice: "Su tiempo se a extendido" }
          format.json { render :show, status: :created, location: @historial }
        end
      else
        total = @historial.pextra * params[:tiempo_extension].to_i
        
        redirect_to historials_extender_path(:id => @historial.id, :usr => @usuario.id, :precio_total => total.to_s, :alquilar_ahora_si => true, :tiempo_extension => params[:tiempo_extension])
      end         
    end
  end

end