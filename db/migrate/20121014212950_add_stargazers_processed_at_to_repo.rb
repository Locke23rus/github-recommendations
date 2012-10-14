class AddStargazersProcessedAtToRepo < ActiveRecord::Migration

  def up
    add_column :repos, :stargazers_processed_at, :datetime
  end

  def down
    remove_column :repos, :stargazers_processed_at, :datetime
  end

end
