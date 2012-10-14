class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
      t.references :repo
      t.integer :user_id

      t.timestamps
    end

    add_index :collaborators, :repo_id
  end
end
