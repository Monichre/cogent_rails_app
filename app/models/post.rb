class Post < ApplicationRecord
  attr_accessor :thumbnailer

  belongs_to :user
  acts_as_taggable_on :tags
  validates :content, :title, presence: true

  def get_user
    user = User.find(self.user_id)
  end

  

end
