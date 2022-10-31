class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.integer :IdInt
      t.string :Patente
      t.string :Marca
      t.string :Modelo
      t.string :Color
      t.boolean :Alquilado
      t.boolean :Enabled
      t.boolean :Deleted
      t.float :PointX
      t.float :PointY

      t.timestamps
    end
  end
end
