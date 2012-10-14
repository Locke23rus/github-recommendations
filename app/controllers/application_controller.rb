class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  before_filter :start_processing

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  def start_processing
    if signed_in? && !current_user.processed?
      current_user.update_attribute(:processed_at, DateTime.current)
      FollowingWorker.perform_async(current_user.id)
    end
  end

end
