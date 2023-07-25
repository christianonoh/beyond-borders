require 'rails_helper'
RSpec.describe 'User posts', type: :feature do
  describe 'Show Page' do
    before(:each) do
      @user1 = User.create(name: 'Usom', photo: 'https://source.unsplash.com/user/c_v_r/100x100', bio: 'Usom bio')
      @user2 = User.create(name: 'Burger', photo: 'https://i.picsum.photos/id/216/200/300.jpg?hmac', bio: 'Burger bio')
      @post1 = Post.create(title: 'Post 1', text: 'Post content goes here', author_id: @user1.id)
      @comment1 = Comment.create(post_id: @post1.id, text: 'First comment goes here', author_id: @user1.id)
      @comment2 = Comment.create(post_id: @post1.id, text: 'Second comment goes here', author_id: @user2.id)
      @comment3 = Comment.create(post_id: @post1.id, text: 'Third comment goes here', author_id: @user2.id)
      @like1 = Like.create(author_id: @user1.id, post_id: @post1.id)
      @like2 = Like.create(author_id: @user1.id, post_id: @post1.id)
      @like3 = Like.create(author_id: @user2.id, post_id: @post1.id)
      visit user_post_path(@user1, @post1)
    end
    it 'should have the title of the post' do
      expect(page).to have_content(@post1.title)
    end
    it 'should have the author of the post' do
      expect(page).to have_content("by #{@post1.user.name}")
    end
    it 'should have the content of the post body' do
      expect(page).to have_content(@post1.text)
    end
    it 'displays the number of comments each post has' do
      expect(page).to have_content("Comments: #{@post1.comments.count}")
    end
    it 'displays the number of likes each post has' do
      expect(page).to have_content("Comments: #{@post1.likes.count}")
    end
    it 'should see post body' do
      expect(page).to have_content(@post1.text)
    end
    it 'should have post comments' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end
    it 'should have post comments authors' do
      expect(page).to have_content(@comment1.user.name)
      expect(page).to have_content(@comment2.user.name)
      expect(page).to have_content(@comment3.user.name)
    end
  end
end
