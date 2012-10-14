class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.find_or_update_with_omniauth!(auth) || User.create_with_omniauth!(auth)
    session[:user_id] = user.id
    redirect_to user_path(user), notice: "Signed in."
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out."
  end

end
