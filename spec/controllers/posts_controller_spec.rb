require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  describe 'PUT vote' do
    it 'updates score when counting vote' do
      sign_in user

      expect do
        put :vote, id: post.id
        post.reload
      end.to change { post.score }
    end
  end
end
