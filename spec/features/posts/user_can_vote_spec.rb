require 'rails_helper'

feature "User can vote" do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context "when not logged in" do
    scenario "must log in to vote" do
      visit post_path(post)
      click_on "This sucks"
      expect(page).to have_content "You must log in to vote."
      expect(page).to have_content "Log in"
    end
  end

  context "when logged in" do
    scenario "can vote" do
      login_as user
      visit post_path(post)
      expect(page).to have_content "0 votes"
      click_on "This sucks"
      expect(page).to have_content "Voted"
      expect(page).to have_content "1 vote"
    end

    scenario "cannot vote if they have already voted" do
      post.liked_by user
      login_as user
      visit post_path(post)
      expect(page).to have_content "Voted"
      expect(page).to have_content "1 vote"
    end
  end
end