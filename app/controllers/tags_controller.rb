class TagsController < FrontBaseController
  def show
    @tag = Tag.active.find(params[:id])
    @articles = Article
                  .joins(:tags)
                  .preload(:tags, :categories)
                  .published
                  .where(tags: { id: @tag.id })
                  .distinct
                  .order(published_at: :desc)
                  .page(params[:page] || 1)
                  .per(30)
  end
end
