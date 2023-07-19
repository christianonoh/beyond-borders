require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'returns http success and renders correct template and displays placeholder' do
      user = User.create(name: 'Test User')
      get "/users/#{user.id}/posts"

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of Posts:')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns http success and renders correct template and displays placeholder' do
      user = User.create(name: 'Test User')
      post = Post.create(author_id: user.id, title: 'Test Post')

      get "/users/#{user.id}/posts/#{post.id}"

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('Post Details:')
    end
  end
end
