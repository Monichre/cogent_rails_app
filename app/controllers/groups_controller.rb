class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :destroy, :edit]

  def index
  end

  def show
  end

  def new
    @post = Post.new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.users << current_user
    @group.save
    redirect_to home_index_path
  end

  def destroy
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name)
  end

end
