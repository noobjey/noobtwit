require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Dashboards:", type: :feature do

  include Capybara::DSL
  include LoginHelper

  context "a user who is not logged in" do

    context "visits the dashboard" do

      it "and goes to the login page" do
        visit dashboard_path
        expect(current_path).to eq root_path
        expect(page).to have_content "Please login to view your dashboard."
      end
    end
  end


  context "a user who is logged in" do
    before do
      VCR.use_cassette('twitter dashboard') do
        login_user
      end
    end


    context "visits the dashboard page" do
      before do
        VCR.use_cassette('twitter dashboard') do
          visit dashboard_path
        end
      end

      it "and can logout" do
        expect(page).to have_link "Logout"

        click_on "Logout"

        expect(current_path).to eq root_path

        visit dashboard_path
        expect(current_path).to eq root_path
      end

      it "sees their twitter name" do
        has_basic_info?(logged_in_user.name)
      end

      it "sees their twitter screen name" do
        has_basic_info?(logged_in_user.screen_name)
      end

      it "sees the number of tweets they have" do
        has_basic_info?("Tweets: 89")
      end

      it "sees the number of followers" do
        has_basic_info?("Followers: 54")
      end

      it "sees the number of following" do
        has_basic_info?("Following: 65")
      end

      it "sees their profile picture" do
        expect(find_by_id("profile-picture")["src"]).to eq("https://pbs.twimg.com/profile_images/488101956/noobjEdit_normal.jpg")
      end

      it "can post a new tweet" do
        VCR.use_cassette('twitter create tweet') do
          message = "This is just a (to lazy to create a test account) playing with the api test tweet, please ignore."

          within(".create-tweet") do
            fill_in("user[tweet]", with: message)
            click_on("Submit")
          end

          within(".feed-container") do
            expect(page).to have_content(logged_in_user.name)
            expect(page).to have_content(logged_in_user.screen_name)
            expect(page).to have_content(message)
          end
        end
      end

      it "can favorite a tweet" do
        VCR.use_cassette('twitter favorite tweet') do
          within(".feed-container") do

            first_tweet = first(".panel-heading")

            within(first_tweet) do
              favorite_link = first_tweet.first("a")
              favorite_link.click
            end

            within(first_tweet) do
              expect(find("i")[:class]).to have_content("glyphicon-star")
            end
          end
        end
      end
    end
  end


  private

  def has_basic_info?(content)
    within(".basic-info") do
      expect(page).to have_content(content)
    end
  end

end
