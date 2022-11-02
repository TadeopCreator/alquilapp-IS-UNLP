class AddDetailsToSupervisors < ActiveRecord::Migration[7.0]
  def change
    add_column :supervisors, :name, :string
    add_column :supervisors, :surname, :string
    add_column :supervisors, :dni, :string
    add_column :supervisors, :email, :string
    add_column :supervisors, :habilitado, :boolean
    add_column :supervisors, :borrado, :boolean
  end
end
