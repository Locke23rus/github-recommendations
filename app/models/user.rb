class User < ActiveRecord::Base

  has_many :recommendations, :dependent => :destroy
  has_many :skipped_recommendations, :class_name => 'Recommendation', :conditions => 'skip = 1', :dependent => :destroy

  validates :uid, :presence => true, :uniqueness => true
  validates :login, :presence => true, :uniqueness => true

  def self.create_with_omniauth!(auth)
    create! do |user|
      user.uid = auth[:uid]
      user.login = auth[:info][:nickname]
      user.email = auth[:info][:email]
      user.full_name = auth[:info][:name]
      user.avatar_url = auth[:info][:image]
      user.token = auth[:credentials][:token]
      user.followings_count = auth[:extra][:raw_info][:following]
      user.repos_count = auth[:extra][:raw_info][:public_repos]
      user.authorized_at = DateTime.current
    end
  end

  def self.find_or_create_with_github!(hash)
    find_by_uid(hash[:id]) || create_with_github!(hash)
  end

  def self.create_with_github!(hash)
    create! do |user|
      user.uid = hash[:id]
      user.login = hash[:login]
      user.avatar_url = hash[:avatar_url]
    end
  end

end
