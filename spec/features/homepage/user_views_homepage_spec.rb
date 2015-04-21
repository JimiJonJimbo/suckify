require 'rails_helper'

feature "User views homepage" do
  let(:user) { create(:user) }

  context "when not logged in" do
    scenario "sees appropriate links" do
      visit root_path
      expect(page).to have_link "Sign Up", new_user_registration_path
      expect(page).to have_link "Sign In", new_user_session_path
    end

    scenario "sees posts" do
      post = create(:post)
      visit root_path
      expect(page).to have_content post.title
      expect(page).to have_link post.link, href: post.link
      expect(page).to have_content post.description
    end
  end

  context "when logged in" do
    scenario "sees appropriate links" do
      login_as user
      visit root_path
      expect(page).to have_link "New Post", new_post_path
      expect(page).to have_link "Sign Out", destroy_user_session_path
    end
  end
end