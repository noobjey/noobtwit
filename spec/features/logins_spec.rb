require 'rails_helper'
require 'support/login_helper'

RSpec.feature "Logins", type: :feature do

  include Capybara::DSL
  include LoginHelper

  before do
    Capybara.app = Noobtwit::Application
    stub_omniauth()
  end

  describe "a user that visits the login page" do
    let(:login_button) { "Login with Twitter" }

    before do
      visit root_path
    end

    context "and is not logged in" do

      it "sees a login button" do
        expect(current_path).to eq root_path
        expect(page).to have_link login_button
      end

      it "can login" do
        click_on login_button

        expect(current_path).to eq dashboard_path
        expect(page).to have_content "Logged in as #{logged_in_user.name}"
      end
    end


    context "and has already logged in", focus: true do

      before do
        VCR.use_cassette('twitter user info') do
          visit root_path
          click_on login_button
        end
      end

      it "sees their dashboard" do
        VCR.use_cassette('twitter user info') do
          visit root_path

          expect(current_path).to eq(dashboard_path)
        end
      end
    end
  end
end
