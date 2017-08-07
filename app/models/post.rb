class Post < ActiveRecord::Base
  acts_as_votable

  belongs_to :user

  validates :link, presence: true, url: true
  validates :title, presence: true
  validates :thumbnail, url: true, allow_blank: true

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
