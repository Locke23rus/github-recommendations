# -*- encoding : utf-8 -*-

class GithubClient

  attr_reader :client

  def initialize(login, token)
    @client ||= Octokit::Client.new(:login => login, :oauth_token => token)
  end

  def self.per_page
    100
  end

  def fetch_followings(user)
    fetch do |client, page|
      client.following(user, :per_page => per_page, :page => page)
    end
  end

  def fetch_repositories(user)
    objects = fetch do |client, page|
      client.repos(user, :per_page => per_page, :page => page)
    end
    original_repos(objects)
  end

  def fetch_starred(user)
    objects = fetch do |client, page|
      client.starred(user, :per_page => per_page, :page => page)
    end
    original_repos(objects)
  end

  def fetch_collaborators(repo)
    fetch do |client, page|
      client.collaborators(repo, :per_page => per_page, :page => page)
    end
  end

  def fetch_forks(repo)
    fetch do |client, page|
      client.forks(repo, :per_page => per_page, :page => page)
    end
  end

  def fetch_stargazers(repo)
    fetch do |client, page|
      client.stargazers(repo, :per_page => per_page, :page => page)
    end
  end

  private

  def original_repo(repos)
    repos.map { |o| o[:fork] ? client.repo(o[:full_name])[:source] : o }
  end

  def fetch
    i = 1
    objects = []
    loop do
      begin
        result = yield(client, page)
      rescue Octokit::InternalServerError, Octokit::BadGateway, Octokit::ServiceUnavailable
        retry
      end
      objects += result
      i += 1
      break if result.size < per_page
    end
    objects
  end

end
