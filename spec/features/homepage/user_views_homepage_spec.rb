require 'rails_helper'

feature "User views homepage" do
  let(:user) { create(:user) }

  context "when not logged in" do
    scenario "sees appropriate links" do
      visit root_path
      expect(page).to have_link "Sign up", new_user_registration_path
      expect(page).to have_link "Log in", new_user_session_path
    end

    scenario "sees posts" do
      post = create(:post)
      visit root_path
      expect(page).to have_link post.title, href: post.link
    end
  end

  context "when logged in" do
    scenario "sees appropriate links" do
      login_as user
      visit root_path
      expect(page).to have_link "New post", new_post_path
      expect(page).to have_link "Log out", destroy_user_session_path
    end
  end
end