class AddIndexOnReposOwnerId < ActiveRecord::Migration

  def change
    add_index(:repos, [:name, :owner_id], :unique => true)
  end

end
