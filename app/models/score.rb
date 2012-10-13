class Score < ActiveRecord::Base

  belongs_to :recommendation
  belongs_to :user

  validates :recommendation, :presence => true
  validates :user, :presence => true

end
