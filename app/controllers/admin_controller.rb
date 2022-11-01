class AdminController < ApplicationController
  def dashboards
    @autos = Auto.all

    puts("kahdfjasdhfasdhfjklasdhfjkashdkfhjkajhkdfjasdfkj: ", @autos)
  end

  def add_supervisor
    #generated_password = Devise.friendly_token.first(8)
    user = User.create!(:email => 'ss@s.com', :password => 'asdasd', :role => :supervisor)

    puts('Supervisor added')
  end
end
