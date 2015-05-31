require 'rails_helper'

feature "User creates new post" do
  let(:user) { create(:user) }

  context "when not logged in" do
    scenario "gets redirected to login page" do
      visit new_post_path
      expect(current_path).to eq new_user_session_path
    end
  end

  context "when logged in" do
    scenario "can create new post" do
      login_as user
      visit new_post_path
      fill_in "Link", with: "http://www.example.com/"
      fill_in "Title", with: "This site sucks"
      click_on "Create Post"
      expect(current_path).to eq "/posts/this-site-sucks"
      expect(page).to have_content "Post successfully created"
      expect(page).to have_link "This site sucks", href: "http://www.example.com/"
      expect(page).to have_content user.username
      expect(page).to have_content "less than a minute ago"
    end
  end
end