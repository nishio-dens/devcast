class FeedsController < ApplicationController
  def index
    @articles = Article
                  .preload(:tags, :categories)
                  .published
                  .order(published_at: :desc)
                  .limit(30)
    render "feed.rss", layout: false
  end
end
