# -*- encoding : utf-8 -*-

class ScoreWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'seldom'

  def perform(recommendation_id)
    recommendation = Recommendation.find(recommendation_id)
    recommendation.prepare_score
  end

end
