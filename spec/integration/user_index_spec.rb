require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  before(:each) do
    @user1 = User.create(name: 'Usom Factory', photo: 'https://source.unsplash.com/user/c_v_r/100x100', bio: 'Usom bio')
    @user2 = User.create(name: 'Burger', photo: 'https://i.picsum.photos/id/216/200/300.jpg?hmac', bio: 'Burger bio')

    visit users_path
  end

  it 'displays the username of all other users' do
    expect(page).to have_content('Kotonko')
    expect(page).to have_content('Usom')
  end

  it 'should have profile picture content of all other users' do
    expect(page).to have_css("img[src*='/images/default.jpg']")
    expect(page).to have_css("img[src*='/images/default.jpg']")
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
