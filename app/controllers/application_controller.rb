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

  def after_update_path_for(resource)
    :user_session
  end

    # POST /resource
    def create(scope)
        puts('Hola desde controller')        
    end
    
  # To reset the db: rake db:reset db:migrate

end
