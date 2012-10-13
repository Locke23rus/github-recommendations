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

  scope :skipped, where(:skip => true)
  scope :autoskipped, skipped.where(:skip_type => SKIP_TYPES[:auto])
  scope :available, where(:skip => false).order('score DESC')

  def prepare(user, repo)
    self.user = user
    self.repo = repo
    save
  end

end
