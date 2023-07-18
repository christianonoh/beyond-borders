class PostsController < ApplicationController
  def index
    @user = User.find(params[:id])
    @posts = @user.posts
  end

  def show
    @post = Post.find_by_id(params[:id])
  end
end