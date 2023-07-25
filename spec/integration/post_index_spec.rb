require 'rails_helper'

RSpec.describe 'User posts', type: :feature do
  describe 'Show Page' do
    before(:each) do
      @user1 = User.create(name: 'Usom', photo: 'https://dummyimage.com/200x200/3498db/ffffff', bio: 'Usom bio')
      @user2 = User.create(name: 'Burger', photo: 'https://dummyimage.com/250/ffffff/000000', bio: 'Burger bio')
      @post1 = Post.create(title: 'Post 1', text: 'Post content goes here', author_id: @user1.id)
      @comment1 = Comment.create(post_id: @post1.id, text: 'First comment goes here', author_id: @user1.id)
      @comment2 = Comment.create(post_id: @post1.id, text: 'Second comment goes here', author_id: @user2.id)
      @comment3 = Comment.create(post_id: @post1.id, text: 'Third comment goes here', author_id: @user2.id)
      @like1 = Like.create(author_id: @user1.id, post_id: @post1.id)
      @like2 = Like.create(author_id: @user1.id, post_id: @post1.id)
      @like3 = Like.create(author_id: @user2.id, post_id: @post1.id)

      visit user_posts_path(@user1)
    end

    it 'Should have profile picture content of user' do
      expect(page).to have_css("img[src*='https://dummyimage.com/200x200/3498db/ffffff']", visible: :visible)
    end

    it 'should have user name' do
      expect(page).to have_content(@user1.name)
    end

    it 'should have user bio' do
      expect(page).to have_content(@user1.bio)
    end

    it 'should have part content of the post body' do
      expect(page).to have_content(@post1.text[0, 50])
    end

    it 'displays the number of comments each post has' do
      expect(page).to have_content("Comments: #{@post1.comments.count}")
    end

    it 'displays the number of likes each post has' do
      expect(page).to have_content("Comments: #{@post1.likes.count}")
    end

    it 'Should see post body' do
      expect(page).to have_content(@post1.text)
    end

    it 'Should have post first 3 comments' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end

    it 'Should redirect to the post page when a post is clicked' do
      click_link 'Post 1'
      expect(page).to have_current_path(user_post_path(@user1, @post1))
    end

    it 'should have number of posts' do
      expect(page).to have_content("#{@user1.posts.count} posts")
    end

    it 'should have title of posts' do
      expect(page).to have_content('Post 1')
    end
  end
end
