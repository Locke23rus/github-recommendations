class User < ActiveRecord::Base

  has_many :repos, :foreign_key => 'owner_id'
  has_many :recommendations, :dependent => :destroy
  has_many :skipped_recommendations, :class_name => 'Recommendation', :conditions => 'skip = 1', :dependent => :destroy
  has_many :user_followings, :dependent => :delete_all
  has_many :followings, :through => :user_followings

  validates :login, :presence => true, :uniqueness => true

  def self.create_with_omniauth!(auth)
    create! do |user|
      user.id = auth[:uid]
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
    find_by_id(hash[:id]) || create_with_github!(hash)
  end

  def self.create_with_github!(hash)
    create! do |user|
      user.id = hash[:id]
      user.login = hash[:login]
      user.avatar_url = hash[:avatar_url]
    end
  end

  def prepare_stars_and_repos(user = login)
    stars_and_repos = fetch_starred(user) + fetch_repositories(user)
    stars_and_repos.uniq { |o| o[:id] }.map do |repo|
      Repo.find_or_create_with_github!(repo)
    end
  end

  def fetch_starred(user = login)
    i = 1
    starred = []
    begin
      starred += client.starred(user, :per_page => 100, :page => i)
      i += 1
    end while starred.size % 100 == 0
    starred
  end

  def fetch_repositories(user = login)
    i = 1
    repositories = []
    begin
      repositories += client.repos(user, :per_page => 100, :page => i)
      i += 1
    end while repositories.size % 100 == 0
    repositories.map { |o| o[:fork] ? client.repo(o[:full_name])[:source] : o }
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
    transaction do
      self.user_followings.clear

      fetch_followings(user).map do |source_following|
        user = User.find_or_create_with_github!(source_following)
        self.user_followings.create! do |user_following|
          user_following.following = user
        end
        user
      end
    end
  end

  def client
    @client ||= Octokit::Client.new(:login => login, :oauth_token => token)
  end

  def prepare_skips
    transaction do
      recommendations.autoskipped.destroy_all

      prepare_stars_and_repos.each do |repo|
        recommendations.create! do |recommendation|
          recommendation.repo = repo
          recommendation.skip = true
          recommendation.skip_type = Recommendation::SKIP_TYPES[:auto]
        end
      end
    end
  end

end
