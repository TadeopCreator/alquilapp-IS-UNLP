class BileterasController < ApplicationController

    def edit
        @billetera = Billetera.find(params[:id])
    end

    def update
        @billetera = Billetera.find(params[:id])
        if @billetera.update(billetera_edit)
            redirect_to @billetera
        else
            render :edit
        end
    end

    private
        def billetera_edit
            params.permit(:saldo)
        end
end
