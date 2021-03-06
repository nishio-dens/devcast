class ArticlesController < FrontBaseController
  def index
    @articles = Article
                  .preload(:tags, :categories)
                  .published
                  .order(published_at: :desc)
                  .page(params[:page] || 1)
                  .per(30)
  end

  def show
    @article = Article.friendly.published.find(params[:id])
  end
end
