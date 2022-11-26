require 'net/http'
require 'net/https'

class AutosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_auto, only: %i[ show edit update destroy ]

  # GET /autos or /autos.json
  def index
    @autos = Auto.all

    make_abstract_request()    
  end

  def make_abstract_request
    url = 'https://ipgeolocation.abstractapi.com/v1/?api_key=' + ENV['ABSTRACT_API_KEY']
    uri = URI(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    request =  Net::HTTP::Get.new(uri)

    response = http.request(request)

    response = JSON.parse(response.body)
    @lon = response["longitude"]
    @lat = response["latitude"]

rescue StandardError => error
    puts "Error (#{ error.message })"
end

  # GET /autos/1 or /autos/1.json
  def show
    @globals = Global.last
  end

  # GET /autos/new
  def new
    @auto = Auto.new
    make_abstract_request() 
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
        if @auto.errors.any?
          @auto.errors.each do |error|
            if (error.full_message == "Num rel has already been taken")
              flash[:notice] = 'Error al agregar vehículo, numero relativo repetido'
            end

            if (error.full_message == "Patente has already been taken")
              flash[:alert] = 'Error al agregar vehículo, patente repetida'
            end
          end
        end

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
        if @auto.errors.any?
          @auto.errors.each do |error|
            if (error.full_message == "Num rel has already been taken")
              flash[:notice] = 'Error al agregar vehículo, numero relativo repetido'
            end

            if (error.full_message == "Patente has already been taken")
              flash[:alert] = 'Error al agregar vehículo, patente repetida'
            end
          end
        end

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
