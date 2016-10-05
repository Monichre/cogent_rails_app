class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    binding.pry
    if user.authenticated?(params[:id])
      binding.pry
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to home_index_path
    else
      render :error
    end
  end
end
