require 'rails_helper'

feature 'User views homepage' do
  let(:user) { create(:user) }

  context 'when not logged in' do
    scenario 'sees appropriate links' do
      visit root_path
      expect(page).to have_link 'Sign up', href: new_user_registration_path
      expect(page).to have_link 'Log in', href: new_user_session_path
    end

    scenario 'sees posts ordered by score' do
      first_post = create(:post, title: 'The first post', created_at: Date.new(2015, 1, 1), user: user)
      second_post = create(:post, title: 'The second post', created_at: Date.new(2015, 1, 2), user: user)
      visit root_path
      expect(page).to have_link first_post.title, href: first_post.link
      expect(page.body.index(second_post.title)).to be < page.body.index(first_post.title)
    end

    scenario 'must log in to post' do
      visit root_path
      click_on 'Share something that sucks'
      expect(current_path).to eq new_user_session_path
    end

    scenario 'can log in without warden helper' do
      visit root_path
      click_on 'Log in'
      fill_in 'Username or email', with: user.login
      fill_in 'Password', with: user.password
      click_button 'Log in'
      expect(page.html).to include I18n.t('devise.sessions.signed_in')
    end
  end

  context 'when logged in' do
    before do
      login_as user
    end

    scenario 'sees appropriate links' do
      visit root_path
      expect(page).to have_link 'New post', href: new_post_path
      expect(page).to have_link 'Log out', href: destroy_user_session_path
    end

    scenario 'can post' do
      visit root_path
      click_on 'Share something that sucks'
      expect(current_path).to eq new_post_path
    end
  end
end
