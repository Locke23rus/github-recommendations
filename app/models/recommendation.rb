class Recommendation < ActiveRecord::Base

  belongs_to :user
  belongs_to :repo

  validates :user_id, :presence => true, :uniqueness => { :scope => :repo_id }
  validates :repo_id, :presence => true

end
