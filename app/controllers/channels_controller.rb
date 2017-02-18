class ChannelsController < ApplicationController
  helper_method :channel, :posts

  private

  def channel
    @channel ||= Channel.find_by_name!(params[:id])
  end

  def posts
    @posts ||= channel.child_posts.published_and_ordered.includes(:developer)
  end
end
