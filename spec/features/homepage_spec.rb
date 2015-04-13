require 'rails_helper'

feature 'Homepage' do
  context 'when signed in' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'user sees appropriate links' do
      login_as user
      visit root_path
      expect(page).to have_link 'New Post', new_post_path
      expect(page).to have_link 'Sign Out', destroy_user_session_path
    end
  end

  context 'when not signed in' do
    scenario 'user sees appropriate links' do
      visit root_path
      expect(page).to have_link 'Sign Up', new_user_registration_path
      expect(page).to have_link 'Sign In', new_user_session_path
    end
  end
end