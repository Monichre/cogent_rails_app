class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :destroy, :update]

  def new
  end

  def index
  end

  def show
  end

  def edit
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def create
    @post = current_user.posts.create(post_params)
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js
    end
  end

  def update
    if !(@post.tag_list.include?(params[:value]))
      @post.tag_list.add(params[:value])
      @post.save
      @tags = @post.tag_list
      respond_to do |format|
        format.html { redirect_to 'home#index' }
        format.js
      end
    else
      flash[:notice] = "Well, that didn't quite work did it?"
      redirect_to home_index_path
    end
  end

  def destroy

  end

  private

  def post_params
    params.require(:post).permit(:content, :title, :url, :user_id, :tag_list, :value)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end
