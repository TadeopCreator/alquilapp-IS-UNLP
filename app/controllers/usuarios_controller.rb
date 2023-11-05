class UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[ show edit update destroy ]
  

  # GET /usuarios or /usuarios.json
  def index
    @usuarios = Usuario.all
  end

  # GET /usuarios/1 or /usuarios/1.json
  def show
    if (!user_signed_in?)
      redirect_to user_session_path
    end
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id])
    @foto = @usuario.image.original_filename
  end

  # POST /usuarios or /usuarios.json
  def create
    @usuario = Usuario.new(usuario_params)
    @usuario.send_license = 1
    @usuario.lock = false

      if @usuario.save
        redirect_to new_user_registration_path
      else  
        
            error = @usuario.errors.where(:birthdate).last
            error2 = @usuario.errors.where(:date_licence).last     
        
            if (error != nil)
              if (error.type == "Es menor de edad")
                flash[:notice] = 'No cuentas con la edad mínima para conducir en la Argentina'
              end
            end
        
            if (error2 != nil)
              if (error2.type == "Expiro licencia")
                flash[:notice] = 'Licencia de conducir expirada'
              end
            end
            
            redirect_to new_usuario_path
        #format.html { render :new, status: :unprocessable_entity }
        #format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end

  end

  # PATCH/PUT /usuarios/1 or /usuarios/1.json
  def update
    respond_to do |format|
      original_imagen = @usuario.image.original_filename
      original_fecha = @usuario.date_licence
      nueva_fecha = params[:usuario][:date_licence]
      if ((params[:usuario][:image] != nil) || (original_fecha != nueva_fecha))
        if (params[:usuario][:image] != nil)
          nueva_imagen = params[:usuario][:image].original_filename
        else
          nueva_imagen = original_imagen
        end
        if ((original_imagen != nueva_imagen) || (original_fecha != nueva_fecha)) && (@usuario.errors.where(:date_licence).last == nil)
          @usuario.send_license = 1 #Establece el valor del status del envio de la licencia
          @usuario.enable = false
        end
      end
      if @usuario.update(usuario_params)
        format.html { redirect_to autos_path, notice: "Perfil actualizado exitosamente" }
        format.json { render autos_path, status: :ok, location: @usuario }
      else
        error = @usuario.errors.where(:birthdate).last
        error2 = @usuario.errors.where(:date_licence).last     
    
        if (error != nil)
          if (error.type == "Es menor de edad")
            flash[:notice] = 'No cuentas con la edad mínima para conducir en la Argentina'
          end
        end
    
        if (error2 != nil)
          if (error2.type == "Expiro licencia")
            flash[:notice] = 'Licencia de conducir expirada'
          end
        end
        
        #redirect_to edit_usuario_path
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @usuario.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1 or /usuarios/1.json
  def destroy
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to usuarios_url, notice: "Usuario was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def usuario_params
      params.require(:usuario).permit(:name, :lastname, :dni, :contact, :lon, :lat, :deleted, :enable, :birthdate, :image, :date_licence, :id_wallet, :send_license)
    end
end
