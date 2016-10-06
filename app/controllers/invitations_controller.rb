class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
    @group = Group.find(params[:group_id])
    respond_to do |format|
      format.html { redirect_to new_user_group_invitation_path(current_user, @group) }
      format.js
    end
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @invitation.sender_id = current_user.id
    @invitation.group_id = params[:group_id]
    if @invitation.save
      flash[:notice] = "Thank you. Invitation sent!"
      redirect_to home_index_path
    else
      flash[:notice] = "Well that didn't work!"
      render :new
    end
  end

  private
  def invitation_params
    params.require(:invitation).permit(:recipient_email)
  end
end
