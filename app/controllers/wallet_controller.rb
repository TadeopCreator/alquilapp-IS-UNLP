class WalletController < ApplicationController
before_action :authenticate_user!

    def show
        unless (user_signed_in? && current_user.user?)
            redirect_to new_user_session_path
        end
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

            if (params["wallet"] != nil)          
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
                    @parms = {}
                    @parms[:name] = params["wallet"]["name"]
                    @parms[:lastname] = params["wallet"]["lastname"]
                    @parms[:address] = params["wallet"]["address"]
                    @parms[:country] = params["wallet"]["country"]
                    @parms[:state] = params["wallet"]["state"]
                    @parms[:zip] = params["wallet"]["zip"]
                    @parms[:cname] = params["wallet"]["cname"]
                    @parms[:cnumber] = params["wallet"]["cnumber"]
                    @parms[:cexpiration] = params["wallet"]["cexpiration"]
                    @parms[:ccvv] = params["wallet"]["ccvv"]
                    @parms[:amount] = params["wallet"]["amount"]

                    redirect_to(wallet_edit_path(@parms))
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
    end

    private
        def wallet_params
            params.permit(:saldo)
        end

        def card_edit
            params.require(:tarjetum).permit(:name,:number,:vto,:cvv)
        end
end
