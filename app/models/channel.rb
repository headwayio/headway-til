class Channel < ApplicationRecord
  has_and_belongs_to_many :posts

  mount_uploader :icon, IconUploader

  validates_presence_of :name

  scope :development, -> { where(development: true) }
  scope :design,      -> { where(design: true) }

  def to_param
    name
  end

  def posts_count
    posts.published.count
  end

  def child_posts
  end
end
