class RemoveUidFromUsers < ActiveRecord::Migration

  def up
    remove_index :users, :uid
    remove_column :users, :uid
  end

  def down
    add_column :users, :uid, :integer
    add_index :users, :uid, :unique => true
  end

end
