class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    if User.exists?(user.id)
      remember user
      #saving using here in the controller to update any recent data from the omniauth facebook response
      user.save
      session[:user_id] = user.id
      redirect_to home_index_path
      flash[:notice]= "Welcome back!"
    else
      user.save
      session[:user_id] = user.id
      redirect_to home_index_path
      flash[:notice]= "Thank you for signing up, you'll receive a confirmation email shortly. Please register your group and invite friends. #{new_user_group_path(user)}"

    end
  end

  def show
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
