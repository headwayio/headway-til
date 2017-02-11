class Channel < ApplicationRecord
  belongs_to :parent, class_name: 'Channel'

  has_many :channels, foreign_key: :parent_id, dependent: :nullify

  has_and_belongs_to_many :posts

  mount_uploader :icon, IconUploader

  validates_presence_of :name

  def to_param
    name
  end

  def posts_count
    posts.published.count
  end
end
