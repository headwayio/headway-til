class Post < ApplicationRecord
  validates :body, :developer, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :likes, numericality: { greater_than_or_equal_to: 0 }
  validates :slug, uniqueness: true
  validate :body_size, if: -> { body.present? }

  delegate :twitter_handle,
           :avatar,
           :username,
           :slack_display_name,
           to: :developer,
           prefix: true

  has_and_belongs_to_many :channels

  belongs_to :developer

  before_create :generate_slug
  after_save :notify_slack_on_publication, if: :publishing?

  scope :drafts, -> { where('published_at is null') }
  scope :popular, -> { published.where('likes >= 5') }
  scope :published, -> { where('published_at is not null') }
  scope :published_and_ordered, -> { published.order(published_at: :desc) }

  MAX_TITLE_CHARS = 50
  MAX_WORDS = 200

  def published?
    published_at?
  end

  def display_date
    published_at || created_at
  end

  def twitter_handle
    developer_twitter_handle || ENV['default_twitter_handle']
  end

  def to_param
    slug + '-' + slugified_title
  end

  def increment_likes
    self.max_likes += 1 if self.max_likes == self.likes
    self.likes += 1
    notify_slack_on_likes_threshold if likes_threshold?
    save
  end

  def decrement_likes
    return if self.likes.zero?
    self.likes -= 1
    save
  end

  def notify_slack_on_publication
    notify_slack('create')
  end

  def notify_slack_on_likes_threshold
    notify_slack('likes_threshold')
  end

  def publish
    update(published_at: Time.now)
  end

  def publishable?
    !published? || !persisted?
  end

  def draft?
    !published?
  end

  def related_to_design?
    channels.merge(Channel.design).exists?
  end

  def related_to_development?
    channels.merge(Channel.development).exists?
  end

  private

  def likes_threshold?
    max_likes % 10 == 0 && max_likes_changed?
  end

  def publishing?
    published_at? && published_at_changed?
  end

  def word_count
    body.split(' ').size
  end

  def words_remaining
    MAX_WORDS - word_count
  end

  def body_size
    return if word_count <= MAX_WORDS

    words_remaining_abs = words_remaining.abs
    errors.add :body, "of this post is too long. It is "\
      "#{words_remaining_abs} #{'word'.pluralize(words_remaining_abs)} "\
      "over the limit of 200 words"
  end

  def generate_slug
    self[:slug] ||= SecureRandom.hex(5)
  end

  def slugified_title
    title.downcase.gsub(/[^A-Za-z0-9\s-]/, '').strip.gsub(/(\s|-)+/, '-')
  end

  def notify_slack(event)
    SlackNotifier.new.perform(self, event)
  end

  def self.search(query)
    if query.present?
      haystack = {
        'posts.title'         => 'A',
        'developers.username' => 'B',
        'channels.name'       => 'B',
        'posts.body'          => 'C'
      }.map do |column, rank|
        "setweight(to_tsvector('english', #{column}), '#{rank}')"
      end.join(' || ')

      joins(:developer, :channels)
      .joins("""
        join lateral (
          select
            ts_rank_cd(#{haystack}, plainto_tsquery('english', #{connection.quote(query)})) as rank
        ) ranks on true
      """)
      .where('ranks.rank > 0')
      .order('ranks.rank desc, posts.created_at desc')
    else
      order created_at: :desc
    end
  end
end
