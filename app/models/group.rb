class Group < ApplicationRecord #removed the require 'twitter' line - should work anyway but just making note
  attr_accessor :tweets, :twitter
  before_create :initialize_tweets
  has_and_belongs_to_many :users

  def initialize_tweets
    self.twitter = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end


  def get_tweets
    self.tweets = []
    self.initialize_tweets.search("#{self.description}", result_type: "recent").take(3).collect do |tweet|
      self.tweets << tweet
    end
    self.tweets
  end
end
