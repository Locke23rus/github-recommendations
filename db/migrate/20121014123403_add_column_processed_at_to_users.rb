class AddColumnProcessedAtToUsers < ActiveRecord::Migration

  def up
    add_column :users, :processed_at, :datetime
  end

  def down
    remove_column :users, :processed_at
  end

end
