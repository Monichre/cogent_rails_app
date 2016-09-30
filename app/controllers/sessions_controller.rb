class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to home_index_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:provider, :uid, :oauth_token, :oauth_expires_at, :user_name, :email, :image, :first_name, :last_name, :location, :location_id, :fb_id)
  end
end
