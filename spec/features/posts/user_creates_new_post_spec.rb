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
      fill_in "Description", with: "It's just an example"
      click_on "Create Post"
      expect(page).to have_content "Post successfully created"
      expect(page).to have_link "http://www.example.com/", href: "http://www.example.com/"
      expect(page).to have_content "This site sucks"
      expect(page).to have_content "It's just an example"
    end
  end
end