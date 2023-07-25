require 'rails_helper'

RSpec.describe 'Specific User', type: :feature do
  describe 'Show Page' do
    before(:each) do
      @user1 = User.create(name: 'Usom muah', photo: 'https://dummyimage.com/200x200/3498db/ffffff', bio: 'Usom bio')
      @user2 = User.create(name: 'Burger', photo: 'https://images.unsplash.com/photo-1661956600684-97d3a4320e45?ixlib=rb-4.0.3&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80', bio: 'Burger bio')
      @post1 = Post.create(title: 'Post 1', text: 'Post content goes here', author_id: @user1.id)
      @post2 = Post.create(title: 'Post 2', text: 'Post content goes here', author_id: @user1.id)
      @post3 = Post.create(title: 'Post 3', text: 'Post content goes here', author_id: @user2.id)
      visit user_path(@user1)
    end

    it 'should have profile picture content of user' do
      expect(page).to have_css("img[src*='https://dummyimage.com/200x200/3498db/ffffff']", visible: :visible)
    end

    it 'should have user username' do
      expect(page).to have_content(@user1.name)
    end

    it 'should have user bio' do
      expect(page).to have_content(@user1.bio)
    end

    it 'should have number of posts' do
      expect(page).to have_content("#{@user1.posts.count} posts")
    end

    it 'should have a button to view all of the user\'s posts' do
      expect(page).to have_content('View All Posts')
    end

    it 'should have user first 3 posts' do
      expect(page).to have_content(@post1.title)
      expect(page).to have_content(@post2.title)
    end
  end
end
