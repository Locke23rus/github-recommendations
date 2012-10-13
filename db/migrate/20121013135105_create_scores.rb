class CreateScores < ActiveRecord::Migration

  def change
    create_table :scores do |t|
      t.string :value
      t.string :action_type
      t.references :recommendation
      t.references :user

      t.timestamps
    end

    add_index :scores, :recommendation_id
    add_index :scores, :user_id
  end

end
