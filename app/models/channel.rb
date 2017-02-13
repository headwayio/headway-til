class Channel < ApplicationRecord
  belongs_to :parent, class_name: 'Channel', inverse_of: :channels

  has_many :channels,
           foreign_key: :parent_id,
           dependent: :nullify,
           inverse_of: :parent
  has_many :child_posts,
           through: :channels,
           source: :posts

  has_and_belongs_to_many :posts

  mount_uploader :icon, IconUploader

  validates_presence_of :name

  def to_param
    name
  end

  def posts_count
    posts.published.count
  end

  def child_posts
  end
end
