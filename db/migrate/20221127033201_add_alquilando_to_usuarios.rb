class AddAlquilandoToUsuarios < ActiveRecord::Migration[7.0]
  def change
    add_column :usuarios, :alquilando, :boolean
  end
end
