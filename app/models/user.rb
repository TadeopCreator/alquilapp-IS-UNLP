class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  enum role: [:user, :supervisor, :admin]
  after_initialize :set_default_role, :if => :new_record?
       
  def set_default_role
    self.role ||= :user
  end

end

# admin@admin.com admin123
# supervisor@supervisor.com supervisor123
# user@user.com user123
