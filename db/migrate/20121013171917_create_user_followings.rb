class CreateUserFollowings < ActiveRecord::Migration

  def change
    create_table :user_followings do |t|
      t.references :user
      t.references :following

      t.timestamps
    end

    add_index :user_followings, [:user_id, :following_id], :unique => true
  end

end
