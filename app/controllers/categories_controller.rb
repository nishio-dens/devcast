class CategoriesController < FrontBaseController
  def show
    @category = Category.active.find(params[:id])
    @articles = Article
                  .joins(:categories)
                  .preload(:tags, :categories)
                  .published
                  .where(categories: { id: @category.id })
                  .distinct
                  .order(published_at: :desc)
                  .page(params[:page] || 1)
                  .per(30)

  end
end
