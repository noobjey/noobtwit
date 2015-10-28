class User < ActiveRecord::Base

  def self.find_or_create_from_oauth(auth_data)
    user = find_or_create_by(uid: auth_data[:uid]) do |new_user|
      new_user.name               = auth_data[:info][:name]
      new_user.screen_name        = auth_data[:info][:nickname]
      new_user.oauth_token        = auth_data[:credentials][:token]
      new_user.oauth_token_secret = auth_data[:credentials][:secret]
    end

    user
  end

  def profile_pic
    twitter_service.profile_pic
  end

  def number_of_tweets
    twitter_service.my_tweet_count()
  end

  def number_of_followers
    twitter_service.followers()
  end

  def number_of_following
    twitter_service.following()
  end

  def tweet(text)
    twitter_service.tweet(text)
  end

  def feed
    twitter_service.time_line
  end


  private

  def twitter_service
    @service ||= TwitterService.new(self)
  end
end


