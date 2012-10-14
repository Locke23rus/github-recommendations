# -*- encoding : utf-8 -*-

class RecommendationWorker
  include Sidekiq::Worker

  def perform(user_id, repo_id)
    user = User.find(user_id)
    repo = Repo.find(repo_id)
    recommendation = Recommendation.new.prepare(user, repo)
    recommendation.prepare_score
  end

end
