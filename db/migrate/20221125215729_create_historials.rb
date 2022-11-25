class CreateHistorials < ActiveRecord::Migration[7.0]
  def change
    create_table :historials do |t|
      t.integer :ID_usr
      t.integer :ID_auto
      t.date :Fin
      t.integer :TiempoAlquilado
      t.float :Precio
      t.float :Pextra
      t.boolean :Multa

      t.timestamps
    end
  end
end
