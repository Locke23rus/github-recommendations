class AddForksProcessedAtToRepo < ActiveRecord::Migration
  def up
    add_column :repos, :forks_processed_at, :datetime
  end

  def down
    remove_column :repos, :forks_processed_at
  end

end
