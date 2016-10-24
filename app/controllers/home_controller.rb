class HomeController < ApplicationController
  before_action :set_user

  def index
    @post = Post.new
    if params[:tag]
      @posts = Post.tagged_with(params[:tag])
    else
      @posts = Post.order(created_at: :desc)
    end
    # current_user.rock_tweets.sample do |object| --> The code that almost brought the plane down. **This works in the command line**
    #   puts object.text if object.is_a?(Twitter::Tweet)
    # end
    # current_user.twitter

  end

  private
  def set_user
    if current_user
      @user = current_user
    end
  end
end
