require 'rails_helper'

RSpec.describe 'Specific User', type: :feature do
  describe 'Show Page' do
    before(:each) do
      @user1 = User.create(name: 'Usom muah', photo: 'https://dummyimage.com/200x200/3498db/ffffff', bio: 'Usom bio')
      @user2 = User.create(name: 'Burger', photo: 'https://dummyimage.com/250/ffffff/000000', bio: 'Burger bio')
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

    it 'should redirect to posts page when user is clicked' do
      click_link 'Post 1'
      expect(page).to have_current_path(user_post_path(@user1, @post1))
    end

    it 'should redirect to posts page when user is clicked' do
      click_link 'View All Posts'
      expect(page).to have_current_path(user_posts_path(@user1))
    end
  end
end
