class CreateUsuarios < ActiveRecord::Migration[7.0]
  def change
    create_table :usuarios do |t|
      t.string :name
      t.string :lastname
      t.integer :dni
      t.string :contact
      t.decimal :lon
      t.decimal :lat
      t.boolean :deleted
      t.boolean :enable

      t.timestamps
    end
  end
end
