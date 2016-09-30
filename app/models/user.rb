class User < ApplicationRecord
  has_many :posts
  acts_as_tagger
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.username = auth.info.name
      user.email = auth.info.email
      user.image = auth.info.image
      user.first_name = auth.extra.raw_info.first_name ? auth.extra.raw_info.first_name : ""
      user.last_name = auth.extra.raw_info.last_name ? auth.extra.raw_info.last_name : ""
      user.location = auth.extra.raw_info.location ? auth.extra.raw_info.location.name : ""
      user.location_id = auth.extra.raw_info.location ? auth.extra.raw_info.location.id : ""
      user.fb_id = auth.extra.raw_info.id
      user.save
    end
  end

  def koala()
    facebook = Koala::Facebook::API.new(self.oauth_token)
  end
end
