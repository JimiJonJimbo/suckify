require 'rails_helper'

feature "User creates new post" do
  let(:user) { create(:user) }

  scenario "when not logged in" do
    visit new_post_path
    expect(current_path).to eq new_user_session_path
  end

  scenario "when logged in" do
    login_as user
    visit new_post_path
    fill_in "Link", with: "http://www.example.com/"
    fill_in "Title", with: "This site sucks"
    fill_in "Description", with: "It's just an example"
    click_on "Create Post"
  end
end