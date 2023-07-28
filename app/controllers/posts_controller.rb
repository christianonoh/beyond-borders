class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: %i[create destroy]
  def index
    @user = User.includes(posts: { comments: :user }).find(params[:user_id])
    @posts = @user.posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      flash[:success] = 'Post created successfully'
      redirect_to user_posts_path(current_user)
    else
      flash.now[:error] = 'Post creation failed'
      render :new
    end
  end

  def destroy
    puts "Destroy action reached."
    @post = Post.find(params[:post_id])
    @post.destroy!
    redirect_to user_posts_path(author_id: @post.user.id), notice: 'Post was deleted successfully!'
  end


  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
