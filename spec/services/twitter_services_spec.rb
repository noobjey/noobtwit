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
      tweets = @service.time_line
      expect(tweets.count).to eq(20)
    end
  end

end
