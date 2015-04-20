require 'rails_helper'

feature 'Posts' do
  context 'when not signed in' do
    scenario 'user gets sent to sign in page' do
      visit new_post_path
      expect(current_path).to eq new_user_session_path
    end
  end

  context 'when signed in' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'user can create new post' do
      login_as user
      visit new_post_path
      fill_in 'Link', with: 'http://www.example.com/'
      fill_in 'Title', with: 'You suck'
      fill_in 'Description', with: 'You know you do'
      click_on 'Create Post'
    end
  end
end