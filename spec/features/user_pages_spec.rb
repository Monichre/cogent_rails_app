require 'rails_helper'

describe 'the authentication process' do
  it 'authenticates the user via facebook'do
    user = FactoryGirl.create(:user)
    visit session_path(user)
    expect(page).to have_content 'COGENT'
    # not sure how to do the facebook authentication
  end
  user = FactoryGirl.create(:user)
  post = FactoryGirl.create(:post, user_id: user.id)

  it 'displays home#index route' do
    visit 'home/index'
    expect(page).to have_content 'COGENT'
  end
  it 'creates a post with Ajax', js: true do
    user = FactoryGirl.create(:user)
    post = FactoryGirl.create(:post, user_id: user.id)
    visit home_index_path()
    expect(page).to have_content 'Check this out guys'
  end
  # it 'creates a post with Ajax', js: true do
  #   visit session_path(user)
  #   within(:css, ".card-content") do
  #    find('.card-title').click
  #   end
  #   fill_in 'post_title', :with => 'Yo'
  #   fill_in 'post_content', :with => 'This is cool'
  #   fill_in 'post_url', :with => 'facebook.com'
  #   find('.btn').click
  #   expect(page).to have_content 'Yo facebook.com'
  # end
end
