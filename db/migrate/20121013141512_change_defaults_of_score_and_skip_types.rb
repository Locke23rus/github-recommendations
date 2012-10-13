class ChangeDefaultsOfScoreAndSkipTypes < ActiveRecord::Migration
  def change
    change_column :recommendations, :score, :integer, :default => 0
    change_column :recommendations, :skip_type, :integer, :default => 0
  end
end
