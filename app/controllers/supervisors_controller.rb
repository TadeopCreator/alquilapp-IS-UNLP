class SupervisorsController < ApplicationController
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
    @supervisor = Supervisor.new(supervisor_params)

    respond_to do |format|
      if @supervisor.save
        format.html { redirect_to supervisor_url(@supervisor), notice: "Supervisor was successfully created." }
        format.json { render :show, status: :created, location: @supervisor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @supervisor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /supervisors/1 or /supervisors/1.json
  def update
    respond_to do |format|
      if @supervisor.update(supervisor_params)
        format.html { redirect_to supervisor_url(@supervisor), notice: "Supervisor was successfully updated." }
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
      format.html { redirect_to supervisors_url, notice: "Supervisor was successfully destroyed." }
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
      params.fetch(:supervisor, {})
    end
end
