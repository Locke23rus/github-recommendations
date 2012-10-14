class RecommendationsController < ApplicationController
  before_filter :find_user, :only => [:index]

  def index
    @recommendations = @user.recommendations.available.paginate(:page => params[:page])
  end

  def skip
    @recommendation = current_user.recommendations.available.find(params[:id])
    @recommendation.skip_by_user!

    render json: { status: 'OK' }
  end

  private

  def find_user
    @user = User.enabled.find_by_login(params[:user_id])

    unless @user
      redirect_to root_path, alert: "User not found."
    end
  end

end
