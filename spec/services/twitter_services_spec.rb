require 'rails_helper'
require 'support/login_helper'

RSpec.feature "TwitterServices:", type: :feature do
  include LoginHelper

  before do
    @user ||= create_twitter_user
  end

  it "#tweet_count" do
    VCR.use_cassette('twitter user info') do
      service = TwitterService.new(@user)

      user_tweet_count = service.my_tweet_count

      expect(user_tweet_count).to eq(88)
    end
  end

  it "#followers" do
    VCR.use_cassette('twitter user info') do
      service = TwitterService.new(@user)

      followers = service.followers

      expect(followers).to eq(54)
    end
  end

  it "#following" do
    VCR.use_cassette('twitter user info') do
      service = TwitterService.new(@user)

      following = service.following

      expect(following).to eq(65)
    end
  end

end
