class CreateForks < ActiveRecord::Migration
  def change
    create_table :forks do |t|
      t.references :repo
      t.integer :user_id

      t.timestamps
    end

    add_index :forks, :repo_id
  end
end
