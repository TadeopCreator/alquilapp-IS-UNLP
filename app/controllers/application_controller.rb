class ApplicationController < ActionController::Base

  protected
  def after_sign_in_path_for(resource)
    if current_user.admin?
        :admin_dashboard
    elsif current_user.supervisor?
        :supervisors
    else
        :autos
    end
  end

  protected
  def after_sign_up_path_for(resource)
    if current_user.admin?
        :admin_dashboard
    elsif current_user.supervisor?
        :supervisors
    else
        :user_session
    end
  end

  def after_sign_out_path_for(scope)
    # return the path based on scope
    :terminos_condiciones_show
  end

    # POST /resource
    def create(scope)
        puts('Hola desde controller')        
    end

  # To reset the db: rake db:reset db:migrate

end
