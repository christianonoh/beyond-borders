require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:user_id/posts' do
    it 'returns http success and renders correct template and displays placeholder' do
      user = User.create(name: 'Test User', photo: 'https://source.unsplash.com/user/c_v_r/100x100')
      get "/users/#{user.id}/posts"

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('Test User')
    end
  end

  describe 'GET /users/:user_id/posts/:id' do
    it 'returns http success and renders correct template and displays placeholder' do
      user = User.create(name: 'Test User', photo: 'https://source.unsplash.com/user/c_v_r/100x100')
      post = Post.create(author_id: user.id, title: 'Test Post')

      get "/users/#{user.id}/posts/#{post.id}"

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('Comments')
    end
  end
end
