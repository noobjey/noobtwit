
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
    client.user(user.screen_name).statuses_count
  end
end
