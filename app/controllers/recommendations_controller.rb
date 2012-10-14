class RecommendationsController < ApplicationController

  def index
    @recommendations = current_user.recommendations.available.paginate(:page => params[:page])
  end

  def skip
    @recommendation = current_user.recommendations.available.find(params[:id])
    @recommendation.skip_by_user!

    render json: { status: 'OK' }
  end
end
