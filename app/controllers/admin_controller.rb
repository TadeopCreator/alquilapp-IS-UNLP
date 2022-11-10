class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin?, only: [:admin_dashboard, :admin_supervisores]

  def is_admin?
    unless current_user.admin?
      flash.alert = "Sorry, you don't have permissions to perform this action."
      redirect_to root_path
    end
  end

  def dashboard
    unless current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def supervisores
    unless current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def vehiculos
    unless current_user.admin?
      redirect_to new_user_session_path
    end
  end

  def add_supervisor
    unless current_user.admin?
      redirect_to new_user_session_path
      return
    end
    #generated_password = Devise.friendly_token.first(8)

      # Crea el user del devise con el rol de admin
      user = User.create!(:email => 'admin@admin.com', :password => 'admin123', :role => :admin)

      #admin = Amin.create!(:name => params[:name],:lastname => params[:lastn],:dni => params[:dni],:mail => params[:email],:phone => params[:phone])
      puts('Admin added')
  end
end
