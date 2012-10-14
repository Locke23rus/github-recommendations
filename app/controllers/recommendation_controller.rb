class RecommendationController < ApplicationController
  def skip
    @recommendation = current_user.recommendations.find(params[:id])
    @recommendation.skip_by_user!

    render json: { status: 'OK' }
  end
end
