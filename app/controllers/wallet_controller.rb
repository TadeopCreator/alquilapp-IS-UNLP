class WalletController < ApplicationController
    def show
        user_ID = current_user.id
        sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol=records_array[0]["id_rol"]
        @usuario = Usuario.find(id_rol.to_s)
        @wallet = Wallet.find(@usuario[:id_wallet])
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
        if (params != {"controller"=>"wallet", "action"=>"edit"})
            fallo = false
            
            current_year = Date.today.year
    
            if(params["wallet"]["cexpiration"][0, 4].to_i <= current_year)
                fallo = true
                flash[:notice] = "Tarjeta inválida, Tarjeta vencida"                
            end
    
            if(params["wallet"]["cnumber"].to_s.length != 16)
                fallo = true
                flash[:notice] = "Tarjeta inválida, Numero de tarjeta invalido"                
            end 
            
            if (fallo)
                redirect_to(wallet_edit_path)
            else

            user_ID = current_user.id
            sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
            records_array=ActiveRecord::Base.connection.execute(sql)
            id_rol=records_array[0]["id_rol"]
            @usuario = Usuario.find(id_rol.to_s)
            @wallet = Wallet.find(@usuario[:id_wallet])

            attributes = {}
            attributes[:saldo] = params["wallet"]["amount"].to_s.to_f + @wallet.saldo
            @wallet.update(attributes)
            flash[:notice] = "Se ha agregado saldo exitosamente"
            redirect_to(wallet_show_path)

            end
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
