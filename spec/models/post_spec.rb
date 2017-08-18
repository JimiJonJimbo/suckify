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

  describe '#update_score' do
    it 'updates score before save' do
      post = create(:post, created_at: Date.new(2015, 1, 1))
      expect(post.score).to eq 6356.4977111
      allow(post).to receive(:votes_for).and_return(double(count: 2))
      post.save
      expect(post.score).not_to eq 6356.4977111
    end
  end

  describe '#get_thumbnail' do
    it 'sets thumbnail equal to link if link is an image' do
      post = create(:post, link: 'http://www.example.com/example.png')
      allow(post).to receive(:is_image?).and_return(true)
      post.get_thumbnail
      expect(post.thumbnail).to eq(post.link)
    end

    it 'uses LinkThumbnailer to get thumbnail if link is not an image' do
      post = create(:post, link: 'http://www.example.com/')
      allow(post).to receive(:is_image?).and_return(false)
      allow(LinkThumbnailer).to receive(:generate).and_return(double(images: ['http://www.example.com/example.png']))
      post.get_thumbnail
      expect(post.thumbnail).to eq('http://www.example.com/example.png')
    end
  end
end
