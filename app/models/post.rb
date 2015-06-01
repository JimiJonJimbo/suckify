class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  acts_as_votable

  belongs_to :user

  validates :link, url: true
end
