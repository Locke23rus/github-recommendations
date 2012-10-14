class UsersController < ApplicationController
  before_filter :find_user

  def show
  end

  private

  def find_user
    @user = User.enabled.find_by_login(params[:id])

    unless @user
      redirect_to root_path, alert: "User not found."
    end
  end

end
