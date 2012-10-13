class UserFollowing < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :user
  belongs_to :following, :class_name => User.class.name

end
