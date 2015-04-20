require 'rails_helper'

RSpec.describe Post, :type => :model do
  describe 'valid?' do
    it 'responds with false if link is an invalid url' do
      expect(FactoryGirl.build(:post, link: 'blah')).not_to be_valid
    end
  end
end
