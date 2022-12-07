class CreateMessages < ActiveRecord::Migration[7.0]
  def change
    create_table :messages do |t|
      t.string :title
      t.text :description
      t.text :image_data
      t.integer :message_type
      t.integer :src
      t.integer :dest

      t.timestamps
    end
  end
end
