class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :name
      t.string :lastname
      t.string :dni
      t.string :contact
      t.decimal :lon
      t.decimal :lat
      t.boolean :deleted
      t.boolean :enable
      t.date :birthdate
      t.text :image_data
      t.date :date_licence
      t.integer :id_wallet

      t.timestamps
    end
  end
end
