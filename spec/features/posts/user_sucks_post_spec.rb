require 'rails_helper'

feature "User sucks post" do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context "when not logged in" do
    scenario "must log in to suck a post", :js do
      visit post_path(post)
      click_on "Suck it"
      expect(current_path).to eq new_user_session_path
    end
  end

  context "when logged in" do
    scenario "cannot suck post that has already been sucked" do
      post.liked_by user
      login_as user
      visit post_path(post)
      expect(page).not_to have_content "Suck it"
    end

    scenario "can suck post only once", :js do
      login_as user
      visit post_path(post)
      expect(page).to have_content "0 sucks"
      click_on "Suck it"
      expect(page).to have_content "Sucked"
      expect(page).to have_content "1 suck"
    end
  end
end