class WalletController < ApplicationController
    def show
        user_ID = current_user.id
        sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
        records_array=ActiveRecord::Base.connection.execute(sql)
        id_rol=records_array[0]["id_rol"]
        @usuario=Usuario.find(id_rol.to_s)
        @wallet=Wallet.find(@usuario[:id_wallet])
    end
    def create
        @wallet = Wallet.new(wallet_params)
        if @wallet.save
            redirect_to @wallet
        else
            render :new
        end
    end

    def edit
        user_ID = current_user.id
        sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
        records_array=ActiveRecord::Base.connection.execute(sql)
        id_rol=records_array[0]["id_rol"]
        @usuario=Usuario.find(id_rol.to_s)
        @wallet=Wallet.find(@usuario[:id_wallet])
    end

    def update
        @wallet = Wallet.find(params[:id])
        if @wallet.update(wallet_edit)
            redirect_to @wallet
        else
            render :edit
        end
    end

    private
        def wallet_params
            params.permit(:saldo)
        end

        def card_edit
            params.require(:tarjetum).permit(:name,:number,:vto,:cvv)
        end
end
