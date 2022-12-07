class AddSourceColumnToReport < ActiveRecord::Migration[7.0]
  def change
    add_column :reports, :src, :integer
  end
end
