class Recommendation < ActiveRecord::Base

  belongs_to :user
  belongs_to :repo
  has_many :scores, :dependent => :delete_all

  validates :user_id, :presence => true, :uniqueness => { :scope => :repo_id }
  validates :repo_id, :presence => true

  SKIP_TYPES = {
    :user => 1,
    :auto => 2
  }

end
