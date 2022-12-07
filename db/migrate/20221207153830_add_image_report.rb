class AddImageReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :image_data, :text
  end
end
