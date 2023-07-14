# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'John Doe') }

  it 'is valid with a title, comments_counter, and likes_counter' do
    post = Post.new(title: 'Sample Title', comments_counter: 5, likes_counter: 10, user:)
    expect(post).to be_valid
  end

  it 'is invalid without a title' do
    post = Post.new(title: nil, comments_counter: 5, likes_counter: 10, user:)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is invalid with a title exceeding 250 characters' do
    post = Post.new(title: 'A' * 251, comments_counter: 5, likes_counter: 10, user:)
    expect(post).not_to be_valid
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'is invalid with a negative comments_counter' do
    post = Post.new(title: 'Sample Title', comments_counter: -1, likes_counter: 10, user:)
    expect(post).not_to be_valid
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is invalid with a negative likes_counter' do
    post = Post.new(title: 'Sample Title', comments_counter: 5, likes_counter: -1, user:)
    expect(post).not_to be_valid
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it "increments the user's posts_counter after creation" do
    expect do
      Post.create(title: 'Sample Title', comments_counter: 5, likes_counter: 10, user:)
    end.to change { user.reload.posts_counter }.by(1)
  end

  it "decrements the user's posts_counter after destruction" do
    post = Post.create(title: 'Sample Title', comments_counter: 5, likes_counter: 10, user:)
    expect do
      post.destroy
    end.to change { user.reload.posts_counter }.by(-1)
  end

  it 'returns the 5 most recent comments' do
    user1 = User.new(name: 'Burger Doe', id: 1)
    post = Post.create(title: 'Sample Title', comments_counter: 5, likes_counter: 10, author_id: user1.id)
    older_comment = Comment.create(post:, text: 'Older Comment')

    expect(post.recent_comments).not_to include(older_comment)
  end
end
