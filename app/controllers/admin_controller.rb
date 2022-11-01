class AdminController < ApplicationController
  def dashboards
    
  end

  def add_supervisor
    #generated_password = Devise.friendly_token.first(8)
    user = User.create!(:email => 'supervisor@supervisor.com', :password => 'supervisor123', :role => :supervisor)

    puts('Supervisor added')
  end
end
