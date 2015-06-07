require 'rails_helper'

feature "User views homepage" do
  let(:user) { create(:user) }

  context "when not logged in" do
    scenario "sees appropriate links" do
      visit root_path
      expect(page).to have_link "Sign up", href: new_user_registration_path
      expect(page).to have_link "Log in", href: new_user_session_path
    end

    scenario "sees posts" do
      post = create(:post)
      visit root_path
      expect(page).to have_link post.title, href: post.link
    end

    scenario "must log in to post" do
      visit root_path
      click_on "Share something that sucks."
      expect(current_path).to eq new_user_session_path
    end
  end

  context "when logged in" do
    before do
      login_as user
    end

    scenario "sees appropriate links" do
      visit root_path
      expect(page).to have_link "New post", href: new_post_path
      expect(page).to have_link "Log out", href: destroy_user_session_path
    end

    scenario "can post" do
      visit root_path
      click_on "Share something that sucks."
      expect(current_path).to eq new_post_path
    end
  end
end