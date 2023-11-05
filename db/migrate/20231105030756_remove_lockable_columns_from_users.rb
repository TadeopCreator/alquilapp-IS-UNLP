class RemoveLockableColumnsFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :locked_at, :datetime
    remove_column :users, :failed_attempts, :integer
  end
end
