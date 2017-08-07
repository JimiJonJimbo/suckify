require 'rails_helper'

describe Post do
  describe '#valid?' do
    it 'responds with false if link is not a valid url' do
      expect(build(:post, link: '')).not_to be_valid
    end

    it 'responds with false if thumbnail is not a valid url' do
      expect(build(:post, thumbnail: 'blah')).not_to be_valid
    end

    it 'responds with true if thumbnail is blank' do
      expect(build(:post, thumbnail: '')).to be_valid
    end

    it 'responds with false if title is blank' do
      expect(build(:post, title: '')).not_to be_valid
    end
  end

  describe '#score' do
    it 'responds with score' do
      expect(build(:post, created_at: Date.new(2015, 1, 1)).score).to eq 6356.0
    end
  end
end
