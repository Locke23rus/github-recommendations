class User < ActiveRecord::Base

  has_many :recommendations, :dependent => :destroy
  has_many :skipped_recommendations, :class_name => 'Recommendation', :conditions => 'skip = 1', :dependent => :destroy
  has_many :user_followings
  has_many :followings, :through => :user_followings, :class_name => User.class.name

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

  def stars_and_repos(user = login)
    client.starred(user) + client.repositories(user)
  end

  def starred(user = login)
    i = 1
    starred_repos = []
    begin
      starred_repos += client.starred(user, :per_page => 100, :page => i)
      i += 1
    end while starred_repos.size % 100 == 0
    starred_repos
  end

  def repositories(user = login)
    i = 1
    repositories = []
    begin
      repositories += client.repos(user, :per_page => 100, :page => i)
      i += 1
    end while repositories.size % 100 == 0
    repositories.map { |h| i[:fork] ? client.repo(h[:full_name])[:source] : h }
  end

  def fetch_followings(user = login)
    i = 1
    users = []
    begin
      users += client.following(user, :per_page => 100, :page => i)
      i += 1
    end while users.size % 100 == 0
    users
  end

  def prepare_followings(user = login)
    fetch_followings(user).map do |source_following|
      User.find_or_create_with_github!(source_following)
    end

  end

  def client
    @client ||= Octokit::Client.new(:login => login, :oauth_token => token)
  end

end
