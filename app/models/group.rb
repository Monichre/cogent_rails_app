require 'twitter'

class Group < ApplicationRecord
  attr_accessor :tweets, :twitter
  before_create :initialize_tweets
  has_and_belongs_to_many :users


  def get_tweets # LIKEWISE -- does this need to be a class level method?
    # self.tweets = []
    # i = self.description.split(',').length - 1
    # while i >= 0
    #   self.tweets << description.split(',')[i]
    #   i -= 1
    # end ----------------------> Twitter API client potentially runs the streaming API with a string -- dont parse array.
    # self.tweets.each do |tweet|
    self.initialize_tweets.filter(track: self.description) do |tweet_object|
      tweet_object
    end
    # end
  end

  def initialize_tweets # does this need to be a class level method? -- NOPE -- well I don't think ^^
    self.twitter = Twitter::Streaming::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
      config.access_token        = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
    self.twitter.filter_level = medium
  end
end
