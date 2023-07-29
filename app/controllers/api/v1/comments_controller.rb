class Api::V1::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }

  def index
    user = User.find(params['user_id'])
    post = user.posts.find(params['post_id'])
    comments = post.comments
    render json: comments
  end

  def create
    token = request.headers['X-Token']
    user = User.find_by(api_token: token)
    post = Post.find(params['post_id'])

    new_comment = post.comments.new(
      text: params['text'],
      user:
    )

    new_comment.save
    render json: { success: 'Comment added successfully' }
  rescue StandardError => e
    render json: { error: e.message }
  end
end
