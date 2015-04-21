require 'rails_helper'

describe Post do
  describe "#valid?" do
    it "responds with true if link is a valid url" do
      expect(FactoryGirl.build(:post, link: "http://www.example.com/")).to be_valid
    end

    it "responds with false if link is not a valid url" do
      expect(FactoryGirl.build(:post, link: "")).not_to be_valid
    end
  end
end
