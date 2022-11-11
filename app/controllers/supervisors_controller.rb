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

    sql = "SELECT * FROM supervisors WHERE contact='" + supervisor_params[:contact] + "'"
    records_array = ActiveRecord::Base.connection.execute(sql)

    if (records_array != [])
      flash[:notice] = 'Ya existe un supervisor con ese email'
      redirect_to new_supervisor_path
      return
    end

    @supervisor = Supervisor.new(:name => supervisor_params[:name], :surname => supervisor_params[:surname], :dni => supervisor_params[:dni], :contact => supervisor_params[:contact], :borrado => supervisor_params[:borrado], :habilitado => supervisor_params[:habilitado])

    respond_to do |format|
      if @supervisor.save
        format.html { redirect_to admin_supervisores_path, notice: "Supervisor creado correctamente. Su contraseña de ingreso es: 'abc123'. Podrá cambiarla iniciando sesión" }
        format.json { render :show, status: :created, location: @supervisor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supervisor.errors, status: :unprocessable_entity }
      end
    end

    # Crea el user del devise con el rol de supervisor
    user = User.create!(:email => @supervisor.contact, :password => 'abc123', :role => :supervisor, :id_rol => @supervisor.id)
  end

  # PATCH/PUT /supervisors/1 or /supervisors/1.json
  def update
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
