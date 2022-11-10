class DropMailSupervisor < ActiveRecord::Migration[7.0]
  def change
    remove_column :supervisors, :email, :string
    add_column :supervisors, :contact, :string
  end
end
