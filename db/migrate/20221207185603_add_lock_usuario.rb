class AddLockUsuario < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :lock, :boolean
  end
end
