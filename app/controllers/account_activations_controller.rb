class AccountActivationsController < ApplicationController

  def new
    if invitation = Invitation.find_by(invitation_token: params[:invitation_token])
      @inviter_user = User.find(invitation.sender_id)
      @group = Group.find(invitation.group_id)
      binding.pry
    else
      flash[:notice] = "Invalid invitation token"
    end
  end

  def create
  end

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
