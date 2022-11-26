class GlobalsController < ApplicationController

  def new
    @global = Global.new
  end

  def create
      @global = Global.new(global_params)
      respond_to do |format|
        if @global.save
          format.html { redirect_to admin_precios_path, notice: "Los Precios se han Actualizado" }
          format.json { render :show, status: :created, location: @global }
        else
              render :new
        end
      end
  end

  private
      def global_params
          params.require(:global).permit(:monto_auto, :monto_multa, :cooldown, :tiempo_multa)
      end
end
