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
      login_user()
    end

    context "visits the dashboard page" do
      before do
        visit dashboard_path
      end

      it "and can logout" do
        expect(page).to have_link "Logout"

        click_on "Logout"

        expect(current_path).to eq root_path

        visit dashboard_path
        expect(current_path).to eq root_path
      end
    end
  end

end
