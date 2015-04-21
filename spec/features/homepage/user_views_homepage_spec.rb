require 'rails_helper'

feature "User views homepage" do
  let(:user) { create(:user) }

  scenario "when not logged in" do
    visit root_path
    expect(page).to have_link "Sign Up", new_user_registration_path
    expect(page).to have_link "Sign In", new_user_session_path
  end

  scenario "when logged in" do
    login_as user
    visit root_path
    expect(page).to have_link "New Post", new_post_path
    expect(page).to have_link "Sign Out", destroy_user_session_path
  end
end