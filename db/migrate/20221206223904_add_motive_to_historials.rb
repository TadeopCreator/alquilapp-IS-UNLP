class AddMotiveToHistorials < ActiveRecord::Migration[7.0]
  def change
    add_column :historials, :motive, :string
  end
end
