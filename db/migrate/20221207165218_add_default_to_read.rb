class AddDefaultToRead < ActiveRecord::Migration[7.0]
  def change
    change_column_default :messages, :read, false
  end
end
