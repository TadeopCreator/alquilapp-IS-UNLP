class SupervisorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_supervisor, only: %i[ show edit update destroy ]

  # GET /supervisors or /supervisors.json
  def index
    #@supervisors = Supervisor.all (Funciona si lo saco, solo es para pruebas)
  end

  # GET /supervisors/1 or /supervisors/1.json
  def show
  end

  # GET /supervisors/new
  def new
    @supervisor = Supervisor.new
  end

  # GET /supervisors/1/edit
  def edit
  end

  # POST /supervisors or /supervisors.json
  def create

    error = false

    sql = "SELECT * FROM supervisors WHERE contact='" + supervisor_params[:contact] + "'"
    records_array = ActiveRecord::Base.connection.execute(sql)

    if (records_array != [])
      records_array.each do |record|

        # Si no esta borrado quiere decir que existe un supervisor con el mismo email        
        if (record["borrado"] == nil || record["borrado"] == 0)
          error = true
          flash[:notice] = 'Ya existe un supervisor con ese email'
        end
      end
    end

    # El email no esta repetido entre los supervisores no borrados
    if !(error)
      # Crea el user del devise con el rol de supervisor para validar si el email es invalido
      @user = User.create(:email => supervisor_params[:contact], :password => 'abc123', :role => :supervisor)

      if (@user.errors.any?)
        error = true
        @user.errors.each do |error|
          if (error.full_message == "Email is invalid")
            flash[:alert] = 'Email inválido'          
          end
        end
      end
    else # El email esta repetido
      # Estoy reutilizando en user ya creado
      @user = User.where(email: supervisor_params[:contact])
      
      # Debo de actualizar la contraseña a 'abc123'
      @user.update_attribute(:password => 'abc123')
    end

    if (error)
      @parms = {}
      @parms[:name] = params["supervisor"]["name"]
      @parms[:surname] = params["supervisor"]["surname"]
      @parms[:dni] = params["supervisor"]["dni"]
      @parms[:contact] = params["supervisor"]["contact"]
      @parms[:name] = params["supervisor"]["name"]
      @parms[:habilitado] = params["supervisor"]["habilitado"]        
      redirect_to new_supervisor_path(@parms)
      return
    end
    
    # Crea el supervisor
    @supervisor = Supervisor.new(:name => supervisor_params[:name], :surname => supervisor_params[:surname], :dni => supervisor_params[:dni], :contact => supervisor_params[:contact], :borrado => supervisor_params[:borrado], :habilitado => supervisor_params[:habilitado])    
    
    respond_to do |format|
      if @supervisor.save
        # Si pudo crear el usuario validando q el email no este repetido y creo el supervisor, es hora de actualizar el rol_id
        # con el id del supervisor creado
        attributes = {}
        attributes[:id_rol] = @supervisor[:id]

        @user.update(attributes)

        format.html { redirect_to admin_supervisores_path, notice: "Supervisor creado correctamente. Su contraseña de ingreso es: 'abc123'. Podrá cambiarla iniciando sesión" }
        format.json { render :show, status: :created, location: @supervisor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supervisor.errors, status: :unprocessable_entity }
      end
    end    
  end

  def is_a_valid_email?(email)
    email =~ URI::MailTo::EMAIL_REGEXP
  end

  # PATCH/PUT /supervisors/1 or /supervisors/1.json
  def update

    error = false    

    # Validacion que el email no esta repetido
    sql = "SELECT * FROM supervisors WHERE contact='" + supervisor_params[:contact] + "' AND id <> '" + @supervisor.id.to_s + "'"
    records_array = ActiveRecord::Base.connection.execute(sql)

    if (records_array != [])
      error = true
      flash[:notice] = 'Ya existe un supervisor con ese email'
    end
    
    # Validacion que el email tiene un buen formato
    if not (is_a_valid_email?(supervisor_params[:contact]))
      error = true
      flash[:alert] = 'Email inválido' 
    end

    if (error)
      @parms = {}
      @parms[:name] = params["supervisor"]["name"]
      @parms[:surname] = params["supervisor"]["surname"]
      @parms[:dni] = params["supervisor"]["dni"]
      @parms[:contact] = params["supervisor"]["contact"]
      @parms[:name] = params["supervisor"]["name"]
      @parms[:habilitado] = params["supervisor"]["habilitado"]        
      redirect_to edit_supervisor_path(@parms)
      return
    end

    respond_to do |format|
      if @supervisor.update(supervisor_params)
        format.html { redirect_to admin_supervisores_path, notice: "Supervisor actualizado correctamente" }
        format.json { render :show, status: :ok, location: @supervisor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @supervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /supervisors/1 or /supervisors/1.json
  def destroy
    @supervisor.destroy

    respond_to do |format|
      format.html { redirect_to :admin_dashboard, notice: "Supervisor eliminado correctamente" } 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_supervisor
      @supervisor = Supervisor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def supervisor_params

      params.require(:supervisor).permit(:name, :surname, :dni, :contact, :borrado, :habilitado)

    end
end
