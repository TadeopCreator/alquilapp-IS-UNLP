class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :number
      t.date :vto
      t.integer :cvv

      t.timestamps
    end
  end
end
