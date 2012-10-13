class Repo < ActiveRecord::Base

  belongs_to :owner, :class_name => User.class.name, :foreign_key => "owner_id"
  has_many :recommendations, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :scope => :owner_id }
  validates :owner_id, :presence => true

  def url
    "https://github.com/#{path}"
  end

  def path
    "/#{owner.login}/#{name}"
  end

end
