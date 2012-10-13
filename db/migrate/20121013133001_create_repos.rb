class CreateRepos < ActiveRecord::Migration

  def change
    create_table :repos do |t|
      t.string :name
      t.string :language
      t.integer :owner_id
      t.integer :forks_count, :default => 0
      t.integer :stars_count, :default => 0

      t.timestamps
    end
  end

end
