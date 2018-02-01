class ArticlesController < FrontBaseController
  def index
  end

  def show
    @article = Article.friendly.published.find(params[:id])
  end
end
