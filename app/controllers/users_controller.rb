class UsersController < ApplicationController
  before_action :set_user

  def new
  end

  def edit
  end

  def show
    @friends = @user.koala.get_connections("me", "invitable_friends")
    # binding.pry
    respond_to do |format|
      format.html { redirect_to user_path(@user)}
      format.js
    end
  end

  def create
  end

  private
  def set_user
    @user = current_user
  end
end
