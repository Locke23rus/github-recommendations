class CreateStargazers < ActiveRecord::Migration
  def change
    create_table :stargazers do |t|
      t.references :repo
      t.integer :user_id

      t.timestamps
    end

    add_index :stargazers, :repo_id
  end
end
