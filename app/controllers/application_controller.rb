class ApplicationController < ActionController::Base

  protected

  def after_sign_in_path_for(resource)
    if current_user.admin?
        :admin_dashboard
    elsif current_user.supervisor?
        :supervisor_dashboard
    else
        :edit_user_password
    end
  end  

  def after_sign_out_path_for(scope)
    # return the path based on scope
    root_path
  end

    # POST /resource
    def create(scope)
        puts('Hola desde controller')        
    end

  # To reset the db: rake db:reset db:migrate

end
