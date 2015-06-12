require 'embedly'
require 'json'

class Post < ActiveRecord::Base
  acts_as_votable

  belongs_to :user

  validates :link, url: true

  def thumbnail
    embedly_api = Embedly::API.new :key => '7538ada32412465384e838619f4fc31e',
        :user_agent => 'Mozilla/5.0 (compatible; mytestapp/1.0; my@email.com)'

    obj = embedly_api.extract url: link
    o = obj.first
    image = o.images.first

    if image.present?
      return image['url']
    else
      return nil
    end
  end

  def score
    s = votes_for.count
    order = Math.log([s, 1].max, 10)

    if s > 0
      sign = 1
    elsif s < 0
      sign = -1
    else
      sign = 0
    end

    seconds = created_at.to_i - 1134028003
    return (sign * order + seconds / 45000).round(7)
  end
end
