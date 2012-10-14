# -*- encoding : utf-8 -*-

class GithubClient

  attr_reader :client

  PER_PAGE = 100

  def initialize(login, token)
    @client ||= ::Octokit::Client.new(:login => login, :oauth_token => token)
  end

  def fetch_followings(user)
    fetch do |client, page|
      client.following(user, :per_page => PER_PAGE, :page => page)
    end
  end

  def fetch_repositories(user)
    objects = fetch do |client, page|
      client.repos(user, :per_page => PER_PAGE, :page => page)
    end
    original_repos(objects)
  end

  def fetch_starred(user)
    objects = fetch do |client, page|
      client.starred(user, :per_page => PER_PAGE, :page => page)
    end
    original_repos(objects)
  end

  def fetch_collaborators(repo)
    fetch do |client, page|
      client.collaborators(repo, :per_page => PER_PAGE, :page => page)
    end
  end

  def fetch_forks(repo)
    fetch do |client, page|
      client.forks(repo, :per_page => PER_PAGE, :page => page)
    end
  end

  def fetch_stargazers(repo)
    fetch do |client, page|
      client.stargazers(repo, :per_page => PER_PAGE, :page => page)
    end
  end

  private

  def original_repos(repos)
    repos.map { |o| o[:fork] ? client.repo(o[:full_name])[:source] : o }
  end

  def fetch
    page = 1
    objects = []
    loop do
      begin
        result = yield(client, page)
      rescue Octokit::InternalServerError, Octokit::BadGateway, Octokit::ServiceUnavailable
        retry
      end
      objects += result
      page += 1
      break if result.size < PER_PAGE
    end
    objects
  end

end
