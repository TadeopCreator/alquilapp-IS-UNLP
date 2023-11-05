class AddTiempoExtraToHistorials < ActiveRecord::Migration[7.0]
  def change
    add_column :historials, :tiempo_extension, :integer
  end
end
