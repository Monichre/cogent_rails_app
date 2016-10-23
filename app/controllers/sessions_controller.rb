class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env["omniauth.auth"]) #activation token is created here
    if User.exists?(user.id) && user.activated?
      user.save #saving using here in the controller to update any recent data from the omniauth facebook response
      log_in(user)
      # remember user
      # cookies.permanent[:activation_token] = user.activation_token
      redirect_to home_index_path
    else
      user.save
      binding.pry
      user.send_activation_email # not using an instance variable here might be an issue
      log_in(user)
      redirect_to new_user_group_path(user)
      flash[:notice]= "Thank you for signing up, you'll receive a confirmation email shortly."
    end
  end

  def show
    redirect_to home_index_path
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:provider, :uid, :oauth_token, :oauth_expires_at, :user_name, :email, :image, :first_name, :last_name, :location, :location_id, :fb_id)
  end
end
