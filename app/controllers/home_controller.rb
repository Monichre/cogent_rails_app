class HomeController < ApplicationController
  before_action :set_user
  
  def index
    @post = Post.new
    @posts = Post.order(created_at: :desc)
  end

  private
  def set_user
    if current_user
      @user = current_user
    end
  end
end
