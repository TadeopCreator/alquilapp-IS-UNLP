class AdminController < ApplicationController
  def dashboards
  end

  def add_supervisor
    #generated_password = Devise.friendly_token.first(8)
    user = User.create!(:email => 's2@s.com', :password => 'asdasd', :role => :supervisor)
    puts('Supervisor added')
  end
end
