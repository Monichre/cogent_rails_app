Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
  scope:'email,user_friends,user_likes,user_location,user_posts,user_relationships,user_photos,user_tagged_places,user_religion_politics,rsvp_event', display:'popup'
end
