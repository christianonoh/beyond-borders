# spec/models/like_spec.rb
require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'John Doe') }
  let(:post) { Post.create(author_id: user.id, title: 'Test Post', text: 'Lorem ipsum') }

  describe '#increment_like_count' do
    it 'increments the likes_counter of the associated post' do
      like = Like.create(user:, post:)
      expect { like.increment_like_count }.to change { post.reload.likes_counter }.by(1)
    end
  end

  describe '#decrement_like_count' do
    it 'decrements the likes_counter of the associated post' do
      like = Like.create(user:, post:)
      expect { like.decrement_like_count }.to change { post.reload.likes_counter }.by(-1)
    end
  end
end
