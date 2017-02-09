class Channel < ApplicationRecord
  has_and_belongs_to_many :posts

  validates_presence_of :name

  def to_param
    name
  end

  def posts_count
    posts.published.count
  end
end
