class ChangeDefaultsOfScoreAndSkipTypes < ActiveRecord::Migration
  def up
    change_column :recommendations, :score, :integer, :default => 0
    change_column :recommendations, :skip_type, :integer, :default => 0
  end

  def down
    change_column :recommendations, :score, :integer
    change_column :recommendations, :skip_type, :integer
  end
end
