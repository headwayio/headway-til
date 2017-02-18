module ApplicationHelper
  def fingerprinted_asset(name)
    Rails.env.production? ? "#{name}-#{ASSET_FINGERPRINT}" : name
  end
  alias_method :f, :fingerprinted_asset

  def render_post_channels(post)
    capture do
      concat render('channels/development') if post.related_to_development?
      concat render('channels/design')      if post.related_to_design?
      concat render(post.channels)
    end
  end
end
