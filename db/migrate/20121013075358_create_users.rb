class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :uid
      t.string :login
      t.string :email
      t.string :full_name
      t.string :avatar_url
      t.string :token
      t.integer :followings_count, :default => 0
      t.integer :stars_count, :default => 0
      t.integer :repos_count, :default => 0
      t.datetime :authorized_at

      t.timestamps
    end

    add_index :users, :uid, :unique => true
  end
end
