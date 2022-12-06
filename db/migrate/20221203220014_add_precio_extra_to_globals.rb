class AddPrecioExtraToGlobals < ActiveRecord::Migration[7.0]
  def change
    add_column :globals, :monto_extension, :float
  end
end
