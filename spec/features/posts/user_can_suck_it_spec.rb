require 'rails_helper'

feature "User can suck it" do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context "when not logged in" do
    scenario "must log in to suck it" do
      visit post_path(post)
      click_on "Suck it"
      expect(page).to have_content "You must log in to suck it."
      expect(page).to have_content "Log in"
    end
  end

  context "when logged in" do
    scenario "can suck it" do
      login_as user
      visit post_path(post)
      expect(page).to have_content "0 sucks"
      click_on "Suck it"
      expect(page).to have_content "Sucked"
      expect(page).to have_content "1 suck"
    end

    scenario "cannot suck it if they have already sucked it" do
      post.liked_by user
      login_as user
      visit post_path(post)
      expect(page).not_to have_content "Suck it"
    end
  end
end