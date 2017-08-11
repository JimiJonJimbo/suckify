require 'rails_helper'

feature 'User votes on post' do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  context 'when not logged in' do
    scenario 'must log in to vote' do
      visit post_path(post)
      find('.vote').click
      expect(page.html).to include I18n.t('devise.failure.unauthenticated')
      expect(page).to have_content 'Log in'
    end
  end

  context 'when logged in' do
    before do
      login_as user
    end

    scenario 'can vote' do
      visit post_path(post)
      expect(first('div.post-votes-container').text).to eq '0'
      find('.vote').click
      expect(page).not_to have_content('.vote')
      expect(first('div.post-votes-container').text).to eq '1'
    end

    scenario 'cannot vote if they have already voted' do
      post.liked_by user
      visit post_path(post)
      expect(page).not_to have_content('.vote')
      expect(first('div.post-votes-container').text).to eq '1'
    end
  end
end
