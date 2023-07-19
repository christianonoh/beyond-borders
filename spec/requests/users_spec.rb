require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'returns http success and renders correct template' do
      get '/users'

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
      expect(response.body).to include('List of Users with Post Count:')
    end
  end

  describe 'GET /users/:id' do
    it 'returns http success and renders correct template' do
      user = User.create(name: 'Test User')

      get "/users/#{user.id}"

      expect(response).to have_http_status(:success)
      expect(response).to render_template(:show)
      expect(response.body).to include('User Info:')
    end
  end
end
