
class TwitterService
  attr_reader :client,
              :user

  def initialize(user)
    @user = user
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key    = Figaro.env.twitter_key
      config.consumer_secret = Figaro.env.twitter_secret
      config.access_token        = user.oauth_token
      config.access_token_secret = user.oauth_token_secret
    end

  end

  def my_tweet_count
    user_info.statuses_count
  end

  def followers
    user_info.followers_count
  end

  def following
    user_info.friends_count
  end

  def profile_pic
    user_info.profile_image_uri_https.to_s
  end

  def time_line
    client.home_timeline
  end

  private

  def user_info
    @user_info ||= client.user(user.screen_name)
  end
end
