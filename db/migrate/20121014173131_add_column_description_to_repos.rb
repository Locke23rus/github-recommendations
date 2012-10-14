class AddColumnDescriptionToRepos < ActiveRecord::Migration
  def up
    add_column :repos, :description, :string
  end

  def down
    remove_column :repos, :description
  end
end
