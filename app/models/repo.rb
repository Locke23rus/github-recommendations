class Repo < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :owner, :class_name => User.class.name, :foreign_key => "owner_id"
  has_many :recommendations, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => true
  validates :owner_id, :presence => true, :uniqueness => true

  def url
    "https://api.github.com/repos/#{path}"
  end

  def path
    "#{self.user.login}/#{self.name}"
  end

end
