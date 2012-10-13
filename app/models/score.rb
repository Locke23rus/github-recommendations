class Score < ActiveRecord::Base

  TYPES = {
    0 => 4,
    1 => 3,
    2 => 2,
    3 => 1,
  }

  belongs_to :recommendation
  belongs_to :user

  validates :recommendation_id, :presence => true
  validates :user_id, :presence => true

  def action=(type)
    self.action_type = type
    self.value = TYPES[type] || 1
  end

end
