require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  describe "a user visits the login page" do
    it "sees a login button" do
      visit root_path

      expect(current_path).to eq(root_path)
      expect(page).to have_button("Login")
    end
  end
end
