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

  ACTION_NAMES = {
    0 => 'owner',
    1 => 'collaborators',
    2 => 'forks',
    3 => 'starred'
  }

  ACTION_TYPES = ACTION_NAMES.invert.symbolize_keys!

  def action_name
    ACTION_NAMES[action_type]
  end

end
