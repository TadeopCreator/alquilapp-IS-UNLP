class RegistrationsController < Devise::RegistrationsController
    def new
      super      
    end
    
  
    def create 
      birth = params[:birthday]

      # Tomo el birthday ingresado y el dia de hoy
      birthday = birth[0][8] + birth[0][9]
      birthmonth = birth[0][5] + birth[0][6]
      birthyear = birth[0][0, 4]
      d = DateTime.now
      d.strftime("%Y/%m/%d")

      # Calculo de la edad
      edad = d.year - birthyear.to_i
      if (d.month < birthmonth.to_i && d.day < birthday.to_i)
        edad = edad - 1
      end

      if (edad.to_i < 17)
        flash[:notice] = 'No cuentas con la edad mínima para conducir en la Argentina'
        redirect_to(:new_user_registration) and return
        return
      end
      super
      w = Billetera.new(saldo:0)
      usuario = Usuario.create!(:name => params[:name], :lastname => params[:lastname], 
                :dni => params[:dni], :contact => params[:phone])
      
      # Actuliza el User del devise con el id_rol correspondiente
      @user = User.last
      @user.update_attribute(:id_rol, usuario[:id])
    end
    
    def update
      super
      user_ID = current_user.id

      # Tomo el rol_ID de acuerdo al ID del User
      sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
      records_array = ActiveRecord::Base.connection.execute(sql)
      id_rol = records_array[0]["id_rol"]

      # Tomo al usuario de acuerdo al rol_ID del User
      @usuario = Usuario.find(id_rol.to_s)

      attributes = {}
      attributes[:name] = params[:name]
      attributes[:lastname] = params[:lastname]
      attributes[:dni] = params[:dni]
      attributes[:contact] = params[:phone]

      @usuario.update(attributes)            
    end

    def destroy
      user_ID = current_user.id

      # Tomo el rol_ID de acuerdo al ID del User
      sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
      records_array = ActiveRecord::Base.connection.execute(sql)
      id_rol = records_array[0]["id_rol"]

      # Tomo al usuario de acuerdo al rol_ID del User
      @usuario = Usuario.find(id_rol.to_s)

      # Destruye al usuario
      @usuario.destroy

      super      
    end
end 