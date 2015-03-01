require 'rails_helper'

feature 'Visitor views home' do
  context 'when logged in' do
    let(:user) { FactoryGirl.create(:user) }

    scenario 'sees appropriate links' do
      login_as(user)
      visit root_path
      expect(page).to have_link 'Sign out'
    end
  end

  context 'when not logged in' do
    scenario 'sees appropriate links' do
      visit root_path
      expect(page).to have_link 'Sign up'
      expect(page).to have_link 'Sign in'
    end
  end
end