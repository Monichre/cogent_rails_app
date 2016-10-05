class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    #   user_id = cookies.signed[:user_id]
    #   user = User.find(user_id)
    #   if user.authenticated?(:remember, cookies[:remember_token])
    #     @current_user = user
    #   end
    # end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  # def remember(user)
  #   user.remember
  #   cookies.permanent.signed[:user_id] = user.id
  #   cookies.permanent[:remember_token] = user.remember_token
  # end

  def log_out
    cookies.delete(:activation_token)
    @current_user = nil
  end

  helper_method :current_user, :logged_in?, :log_out, :remember
end
