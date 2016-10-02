require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :username }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should have_and_belong_to_many :groups }

  user = FactoryGirl.create(:user)
  it ' has a first name Liam' do
    expect(user.first_name).to eq "Liam"
  end

  it 'has username Liam Ellis' do
    expect(user.username).to eq "Liam Ellis"
  end
end
