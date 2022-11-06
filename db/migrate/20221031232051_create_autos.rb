class CreateAutos < ActiveRecord::Migration[7.0]
  def change
    create_table :autos do |t|
      t.integer :num_rel
      t.string :patente
      t.string :marca
      t.string :modelo
      t.string :color
      t.boolean :alquilado
      t.boolean :habilitado
      t.boolean :borrado
      t.decimal :lon
      t.decimal :lat

      t.timestamps
    end
  end
end
