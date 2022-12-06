class AddTotalToHistorials < ActiveRecord::Migration[7.0]
  def change
    add_column :historials, :total, :float
  end
end
