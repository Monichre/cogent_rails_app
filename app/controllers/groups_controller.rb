class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :destroy, :edit]

  def index
    @user = current_user
    @groups = @user.groups
  end

  def show
  end

  def new
    @post = Post.new
    @group = Group.new
    @user = current_user
  end

  def edit
  end

  def create
    @user = current_user
    @group = @user.groups.create(group_params)
    if @user.activated?
      redirect_to home_index_path
    else
      redirect_to root_path
    end
  end

  def destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end

end
