# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with a name' do
      user = User.new(name: 'John Doe')
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(name: nil)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is valid with a post_counter greater than or equal to 0' do
      user = User.new(name: 'John Doe', posts_counter: 0)
      expect(user).to be_valid
    end

    it 'is invalid with a negative post_counter' do
      user = User.new(name: 'John Doe', posts_counter: -1)
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
    end
  end

  describe '#recent_posts' do
    it 'returns the 3 most recent posts of the user' do
      user = User.create(name: 'John Doe')
      user.posts.create(title: 'Post 1', text: 'Content 1')
      post2 = user.posts.create(title: 'Post 2', text: 'Content 2')
      post3 = user.posts.create(title: 'Post 3', text: 'Content 3')
      post4 = user.posts.create(title: 'Post 4', text: 'Content 4')

      expect(user.recent_posts).to eq([post4, post3, post2])
    end
  end
end
