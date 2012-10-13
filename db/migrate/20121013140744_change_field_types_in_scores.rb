class ChangeFieldTypesInScores < ActiveRecord::Migration

  def up
    change_column :scores, :value, :integer, :default => 0
    change_column :scores, :action_type, :integer, :default => 0
  end

  def down
    change_column :scores, :value, :string
    change_column :scores, :action_type, :string
  end

end
