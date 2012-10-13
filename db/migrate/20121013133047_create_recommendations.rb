class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.references :user
      t.references :repo
      t.integer :score
      t.boolean :skip, :default => false
      t.integer :skip_type

      t.timestamps
    end

    add_index :recommendations, [:user_id, :score]
    add_index :recommendations, [:user_id, :repo_id], :unique => true
    add_index :recommendations, :skip
    add_index :recommendations, :skip_type
  end
end
