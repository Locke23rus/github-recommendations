class Repo < ActiveRecord::Base

  belongs_to :owner, :class_name => User.name
  has_many :recommendations, :dependent => :destroy

  validates :name, :presence => true, :uniqueness => { :scope => :owner_id }
  validates :owner_id, :presence => true

  def self.find_or_create_with_github!(hash)
    find_by_name_and_owner_id(hash[:name], hash[:owner][:id]) || create_with_github!(hash)
  end

  def self.create_with_github!(hash)
    create! do |repo|
      repo.owner_id = User.find_or_create_with_github!(hash[:owner]).id
      repo.name = hash[:name]
      repo.language = hash[:language]
      repo.forks_count = hash[:forks_count]
      repo.stars_count = hash[:watchers_count]
    end
  end

  def url
    "https://github.com/#{full_name}"
  end

  def full_name
    "#{owner.login}/#{name}"
  end

  def fetch_collaborators(user)
    user.client.fetch_collaborators(full_name)
  end

  def fetch_forks(user)
    user.client.fetch_forks(full_name)
  end

  def fetch_stargazers(user)
    user.client.fetch_stargazers(full_name)
  end

  def collaborator_ids(user)
    fetch_collaborators(user).map {|hash| hash[:id] }
  end

  def forks_owner_ids(user)
    fetch_forks(user).map {|hash| hash[:owner][:id] }
  end

  def stargazers_ids(user)
    fetch_stargazers(user).map {|hash| hash[:id] }
  end

end
