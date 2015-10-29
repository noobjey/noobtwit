require 'rails_helper'
require 'support/login_helper'

RSpec.feature "TwitterServices:", type: :feature do
  include LoginHelper

  before do
    @user ||= create_twitter_user
    @service = TwitterService.new(@user)
  end

  it "#tweet_count" do
    VCR.use_cassette('twitter user info') do
      expect(@service.my_tweet_count).to eq(88)
    end
  end

  it "#followers" do
    VCR.use_cassette('twitter user info') do
      expect(@service.followers).to eq(54)
    end
  end

  it "#following" do
    VCR.use_cassette('twitter user info') do
      expect(@service.following).to eq(65)
    end
  end

  it "#profile_pic" do
    VCR.use_cassette('twitter user info') do
      expect(@service.profile_pic).to eq("https://pbs.twimg.com/profile_images/488101956/noobjEdit_normal.jpg")
    end
  end

  it "#time_line" do
    VCR.use_cassette('twitter time line') do
      expect(@service.time_line.count).to eq(20)
    end
  end

  it "#tweet" do
    VCR.use_cassette('twitter tweet') do
      message = "This is just a (to lazy to create a test account) playing with the api test tweet, please ignore."
      result = @service.tweet(message)

      expect(result.user.name).to eq(logged_in_user.name)
      expect(result.text).to eq(message)
    end
  end

  it "#favorite" do
    VCR.use_cassette('twitter favorite tweet') do
      tweet_id = "659589258596982784"
      tweet = @service.favorite(tweet_id)

      expect(tweet.favorited?).to eq(true)
    end
  end



end
