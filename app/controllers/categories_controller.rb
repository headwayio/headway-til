class CategoriesController < ApplicationController
  helper_method :posts, :category

  def show
  end

  private

  def posts
    case category
    when /development/i then Post.joins(:channels).order(:title).merge(Channel.development)
    when /design/i      then Post.joins(:channels).order(:title).merge(Channel.design)
    else
      Post.includes(:channels).order(:title)
    end
  end

  def category
    @category ||= params[:category]
  end
end
