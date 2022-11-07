class AdminController < ApplicationController
  def dashboards
  end

  def add_supervisor
    #generated_password = Devise.friendly_token.first(8)

      # Crea el user del devise con el rol de admin
      user = User.create!(:email => 'super@super.com', :password => 'super123', :role => :admin)

      #admin = Amin.create!(:name => params[:name],:lastname => params[:lastn],:dni => params[:dni],:mail => params[:email],:phone => params[:phone])
      puts('Admin added')
  end
end
