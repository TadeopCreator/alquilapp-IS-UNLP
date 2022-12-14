class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  def index
    @messages = Message.all
  end

  # GET /messages/1 or /messages/1.json
  def show
    # Marcar como visto
    @message = Message.find(params[:id])

    @message.update_attribute(:read, true)
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages or /messages.json
  def create
    @message = Message.new(message_params)

    puts("Params MENSAJE: ", message_params)

    if (message_params["message_type"] == "0")
      respond_to do |format|
        if @message.save
          format.html { redirect_to supervisors_path, notice: "Mensaje enviado exitosamente" }
          format.json { render :show, status: :created, location: @message }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    elsif (message_params["message_type"] == "2")
      respond_to do |format|
        if @message.save
          format.html { redirect_to autos_path, notice: "Comentario enviado exitosamente" }
          format.json { render :show, status: :created, location: @message }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @message.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def message_params
      params.require(:message).permit(:title, :description, :image, :message_type, :src, :dest)
    end
end
