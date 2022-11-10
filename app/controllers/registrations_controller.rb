class RegistrationsController < Devise::RegistrationsController
    def new
      super      
    end

    def edit
      super
    end
  
    def create
      super      
      usuario = Usuario.last
      
      # Actuliza el User del devise con el id_rol correspondiente
      @user = User.last
      @user.update_attribute(:id_rol, usuario[:id])
    end
    
    def update
      super
      
      if (current_user.user?)
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
        attributes[:image_data] = params[:image]

        @usuario.update(attributes)     
      elsif (current_user.admin?)
        admin_ID = current_user.id
        # Tomo el rol_ID de acuerdo al ID del Admin
        sql = "SELECT * FROM users WHERE id='" + admin_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol = records_array[0]["id_rol"]        

        # Tomo al admin de acuerdo al rol_ID del Admin
        @admin = Admin.find(id_rol.to_s)

        attributes = {}
        attributes[:name] = params[:name]
        attributes[:lastname] = params[:lastname]
        attributes[:dni] = params[:dni]
        attributes[:contact] = params[:phone]

        @admin.update(attributes)

      elsif (current_user.supervisor?)
        supervisor_ID = current_user.id
        # Tomo el rol_ID de acuerdo al ID del Supervisor
        sql = "SELECT * FROM users WHERE id='" + supervisor_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol = records_array[0]["id_rol"]        

        # Tomo al supervisor de acuerdo al rol_ID del Supervisor
        @supervisor = Supervisor.find(id_rol.to_s)

        attributes = {}
        attributes[:name] = params[:name]
        attributes[:surname] = params[:lastname]
        attributes[:dni] = params[:dni]
        attributes[:contact] = params[:phone]

        @supervisor.update(attributes)   
      end             
    end

    def destroy
      if (current_user.user?)
        user_ID = current_user.id

        # Tomo el rol_ID de acuerdo al ID del User
        sql = "SELECT * FROM users WHERE id='" + user_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol = records_array[0]["id_rol"]

        # Tomo al usuario de acuerdo al rol_ID del User
        @usuario = Usuario.find(id_rol.to_s)

        # Destruye al usuario
        @usuario.destroy
      elsif (current_user.admin?)
        admin_ID = current_user.id

        # Tomo el rol_ID de acuerdo al ID del Admin
        sql = "SELECT * FROM users WHERE id='" + admin_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol = records_array[0]["id_rol"]

        # Tomo al usuario de acuerdo al rol_ID del Admin
        @admin = Admin.find(id_rol.to_s)

        # Destruye al admin
        @admin.destroy
      elsif (current_user.supervisor?)
        supervisor_ID = current_user.id

        # Tomo el rol_ID de acuerdo al ID del Supervisor
        sql = "SELECT * FROM users WHERE id='" + supervisor_ID.to_s + "'"
        records_array = ActiveRecord::Base.connection.execute(sql)
        id_rol = records_array[0]["id_rol"]

        # Tomo al usuario de acuerdo al rol_ID del Supervisor
        @supervisor = Supervisor.find(id_rol.to_s)

        # Destruye al admin
        @supervisor.destroy
      end

      super      
    end
end 