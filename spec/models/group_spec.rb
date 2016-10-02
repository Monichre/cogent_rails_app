require 'rails_helper'

RSpec.describe Group, type: :model do
  it { should validate_presence_of :name }
  it { should have_and_belong_to_many :users }

  group = FactoryGirl.create(:group)
  it 'has a name' do
    expect(group.name).to eq 'Our group'
  end

end
