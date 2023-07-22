class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.new(author_id: current_user.id, post_id: @post.id)

    if @like.save
      flash[:success] = 'Post liked successfully'
    else
      Rails.logger.error @like.errors.full_messages # Add this line to log the errors
      flash[:error] = 'Failed to like the post'
    end

    redirect_to user_post_path(user_id: @post.author_id, id: @post.id)
  end

  def destroy
    @like = current_user.likes.find_by(post_id: params[:post_id])

    if @like
      @like.destroy
      flash[:success] = 'Post unliked successfully'
    else
      flash[:error] = 'Failed to unlike the post'
    end

    redirect_to user_post_path(user_id: @like.author_id, id: @like.post_id)
  end
end
