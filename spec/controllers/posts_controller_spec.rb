require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:other_user) }
  let(:post) { create(:post, user: user) }

  describe 'PUT vote' do
    it 'updates score when counting vote' do
      sign_in user
      post.upvote_by other_user

      expect do
        put :vote, id: post.id
        post.reload
      end.to change { post.score }
    end
  end
end
