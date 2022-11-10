class AutosController < ApplicationController
  before_action :set_auto, only: %i[ show edit update destroy ]

  # GET /autos or /autos.json
  def index
    @autos = Auto.all
  end

  # GET /autos/1 or /autos/1.json
  def show
  end

  # GET /autos/new
  def new
    @auto = Auto.new
  end

  # GET /autos/1/edit
  def edit
  end

  # POST /autos or /autos.json
  def create
    @auto = Auto.new(auto_params)

    respond_to do |format|
      if @auto.save
        format.html { redirect_to admin_vehiculos_path, notice: "El vehículo ha sido creado" }
        format.json { render :show, status: :created, location: @auto }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @auto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /autos/1 or /autos/1.json
  def update
    respond_to do |format|
      if @auto.update(auto_params)
        format.html { redirect_to admin_vehiculos_path, notice: "El vehículo ha sido actualizado correctamente" }
        format.json { render :show, status: :ok, location: @auto }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @auto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /autos/1 or /autos/1.json
  def destroy
    @auto.destroy

    respond_to do |format|
      format.html { redirect_to autos_url, notice: "El vehículo ha sido eliminado" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_auto
      @auto = Auto.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def auto_params
      params.require(:auto).permit(:num_rel, :patente, :marca, :modelo, :color, :alquilado, :habilitado, :borrado, :lon, :lat)
    end
end
