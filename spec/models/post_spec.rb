require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :content }

  post = FactoryGirl.create(:post, user_id: 1)
  it 'has a default title' do
    expect(post.title).to eq "Check this out guys"
  end

  it 'has default content' do
    expect(post.content).to eq "stuff to check out"
  end

  it 'has default url' do
    expect(post.url).to eq "www.google.com"
  end
end
