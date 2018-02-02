class FrontBaseController < ApplicationController
  before_action :set_page_categories
  before_action :set_page_tags
  before_action :set_page_new_articles
  before_action :set_header_categories

  def set_page_categories
    @page_categories = Category.all.active
  end

  def set_page_tags
    @page_tags = Tag.all.active
  end

  def set_page_new_articles
    @page_new_articles = Article.published.order(published_at: :desc).take(10)
  end

  def set_header_categories
    @page_header_categories = HeaderCategory
                                .all
                                .preload(:category)
                                .order(:display_order)
  end
end
