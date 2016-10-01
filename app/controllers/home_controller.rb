class HomeController < ApplicationController
  before_action :set_user

  def index
    @post = Post.new
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.order(created_at: :desc)
    end
  end

  private
  def set_user
    if current_user
      @user = current_user
    end
  end
end
