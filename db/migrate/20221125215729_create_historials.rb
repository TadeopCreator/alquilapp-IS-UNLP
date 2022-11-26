class CreateHistorials < ActiveRecord::Migration[7.0]
  def change
    create_table :historials do |t|
      t.integer :id_usr
      t.integer :id_auto
      t.datetime :fin
      t.integer :tiempoAlquilado
      t.float :precio
      t.float :pextra
      t.boolean :multa

      t.timestamps
    end
  end
end
