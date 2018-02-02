class HomeController < FrontBaseController
  def index
    @articles = Article
                  .preload(:tags, :categories)
                  .published
                  .order(published_at: :desc)
                  .page(params[:page] || 1)
  end
end
