class FrontBaseController < ApplicationController
  before_action :set_page_categories
  before_action :set_page_tags
  before_action :set_page_new_articles

  def set_page_categories
    @page_categories = Category.all.active
  end

  def set_page_tags
    @page_tags = Tag.all.active
  end

  def set_page_new_articles
    @page_new_articles = Article.published.order(published_at: :desc).take(10)
  end
end
