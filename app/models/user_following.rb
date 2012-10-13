class UserFollowing < ActiveRecord::Base

  belongs_to :user
  belongs_to :following, :class_name => User.name

  validates :user, :presence => true
  validates :following, :presence => true

end
