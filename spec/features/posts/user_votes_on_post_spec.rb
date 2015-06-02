require 'rails_helper'

feature "User votes on post" do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  # context "when not logged in" do
  # end

  context "when logged in" do
    scenario "sees score change", :js do
      login_as user
      visit post_path(post)
      expect(page).to have_content "0 votes"
      click_on "This sucks"
      expect(page).to have_content "1 vote"
    end
  end
end