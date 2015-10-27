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

  def feed
    [{ name: "GoogleCloudPlatform", screen_name: "@googlecloud", date: "Wed Aug 29 17:12:58 +0000 2012", text: "nso infuriating, iOS9 Safari insists on dumping you in an app for some types of links now, which does not even work half the time." }, { name: "Tome Herman", screen_name: "@th", date: "Wed Aug 29 17:12:58 +0000 2012", text: "nso infuriating, iOS9 Safari insist time." } ]
  end
end


