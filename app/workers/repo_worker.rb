# -*- encoding : utf-8 -*-

class RepoWorker
  include Sidekiq::Worker

  def perform(user_id, following_id)
    user = User.find(user_id)
    following = User.find(following_id)
    user.prepare_stars_and_repos(following.login).each do |repo|
      recommendation = Recommendation.new.prepare(user, repo)
      ScoreWorker.perform_async(recommendation.id) if recommendation.id.present?
    end
  end
end
