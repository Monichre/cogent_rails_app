class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token

  before_create :create_activation_digest

  acts_as_tagger
  has_many :posts
  has_and_belongs_to_many :groups

  # validates :username, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true
  # validates :provider, presence: true
  # validates :uid, presence: true
  # validates :oauth_token, presence: true
  # validates :oauth_expires_at, presence: true
  # validates :email, presence: true
  # validates :image, presence: true
  # validates :fb_id, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
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
      # user.save I'm removing this to see if I can save the user model from the controller after seeing if a user exists prior
    end
  end

  def koala()
    facebook = Koala::Facebook::API.new(self.oauth_token)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #generates random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  #will return true if the given token matches the digest
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest) .is_password?(remember_token)
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
