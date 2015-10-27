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
    "https://pbs.twimg.com/profile_images/488101956/noobjEdit_bigger.jpg"
  end

  def number_of_tweets
    "234"
  end

  def number_of_followers
    "23"
  end

  def number_of_following
    "43"
  end

  def tweet
  #   send info to service to add tweet
  end
end


