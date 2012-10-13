class Score < ActiveRecord::Base

  belongs_to :recommendation
  belongs_to :user

  validates :recommendation_id, :presence => true
  validates :user_id, :presence => true

  def action=(type)
    self.action_type = type
    self.value = 1
  end

end
