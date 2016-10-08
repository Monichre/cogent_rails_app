require 'twitter'

class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :twitter

  before_save :create_activation_digest
  before_save :rock_tweets
  after_initialize :set_invitation_limit

  acts_as_tagger
  has_many :posts
  has_and_belongs_to_many :groups
  has_many :sent_invitations, :class_name => 'Invitation', :foreign_key => 'sender_id'
  has_many :invites, :class_name => "Invitation", :foreign_key => 'recipient_id'

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

  #generates random token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def authenticated?(activation_token)
    BCrypt::Password.new(self.activation_digest) == activation_token.to_s
  end

  def activate
    update_attribute(:activated, true)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  #private
  def create_activation_digest
    self.activation_token = User.new_token.to_s
    self.activation_digest = BCrypt::Password.create(self.activation_token)
  end

  def rock_tweets
    self.twitter = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  private
    def set_invitation_limit
      self.invitation_limit = 5
    end

end
