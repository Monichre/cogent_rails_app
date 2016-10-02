require 'rails_helper'

describe 'the authentication process' do
  it 'authenticates the user via facebook'do
    visit root_path
    expect(page).to have_content 'COGENT SIGN UP'
    # not sure how to do the facebook authentication
  end

  it 'displays home#index route' do
    visit 'home/index'
    expect(page).to have_content 'COGENT'
  end

  user = FactoryGirl.create(:user)
  
  it 'creates a post with Ajax', js: true do
    visit 'home/index'
    click('Add a post or a collage')
    fill_in 'post_title', :with => 'Yo'
    fill_in 'post_content', :with => 'This is cool'
    fill_in 'post_url', :with => 'facebook.com'
    click_on 'CREATE POST'
    expect(page).to have_content 'COGENT SIGN UP'
  end
end
