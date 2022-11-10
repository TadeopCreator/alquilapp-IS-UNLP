class TarjetumsController < ApplicationController
    
    def create
        @tarjetum = Tarjetum.new(tarjetum_params)
        if @tarjetum.save
            redirect_to @tarjetum
        else
            render :new
        end
    end

    def edit
        @tarjetum = Tarjetum.find(params[:id])
    end

    def update
        @tarjetum = Tarjetum.find(params[:id])
        if @tarjetum.update(tarjetum_edit)
            redirect_to @tarjetum
        else
            render :edit
        end
    end

    private
        def tarjetum_params
            params.permit(:name,:number,:vto,:cvv)
        end

        def tarjetum_edit
            params.require(:tarjetum).permit(:name,:number,:vto,:cvv)
        end
end
