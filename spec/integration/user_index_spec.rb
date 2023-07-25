require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Usom Factory', photo: 'https://dummyimage.com/200x200/3498db/ffffff', bio: 'Usom bio')
    @user2 = User.create(name: 'Burger', photo: 'https://i.picsum.photos/id/216/200/300.jpg?hmac', bio: 'Burger bio')

    visit users_path
  end

  it 'displays the username of all other users' do
    expect(page).to have_content('Usom Factory')
    expect(page).to have_content('Burger')
  end

  it 'should have profile picture content of all other users(and displays default if the image link is invalid)' do
    expect(page).to have_css("img[src*='https://dummyimage.com/200x200/3498db/ffffff']", visible: :visible)
    # @user2 image is invalid so we should get the default image
    expect(page).to have_css("img[src*='/images/default.jpg']", visible: :visible)
  end

  it 'displays the number of posts each user has written' do
    expect(page).to have_content("#{@user1.posts_counter} posts")
    expect(page).to have_content("#{@user2.posts_counter} posts")
  end

  it 'should redirect to posts page when user is clicked' do
    click_link 'Usom Factory'
    expect(page).to have_current_path(user_path(@user1))
  end
end
