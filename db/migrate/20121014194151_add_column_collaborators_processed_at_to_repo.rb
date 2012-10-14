class AddColumnCollaboratorsProcessedAtToRepo < ActiveRecord::Migration

  def up
    add_column :repos, :collaborators_processed_at, :datetime
  end

  def down
    remove_column :repos, :collaborators_processed_at
  end

end
