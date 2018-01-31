class ImportArticleRepoService < BaseService
  def initialize(dir, repo_name)
    @dir = dir
    @repo_name = repo_name
  end

  def execute
    validate_repo_dir!

    copy_images(@dir, @repo_name)
    import_articles(@dir, @repo_name)
  end

  private

  def validate_repo_dir!
    fail "Invalid Dir Path" if @dir.length < 10
    fail "Invalid Repo Dir" unless Dir.exists?(@dir)
    fail "Invalid Article Dirs" unless Dir.exists?("#{@dir}/articles")
    fail "Invalid Image Dirs" unless Dir.exists?("#{@dir}/images")
  end

  def copy_images(dir, repo_name)
    image_dir_path = "#{Rails.root}/public/images/#{repo_name}"
    FileUtils.mkdir_p(image_dir_path) unless FileTest.exist?(image_dir_path)
    cmd = "cp -rf #{dir}/images #{image_dir_path}"
    Rails.logger.info("EXECUTE #{cmd}")
    `#{cmd}`
  end

  def import_articles(dir, repo_name)
    article_paths = Dir.glob("#{dir}/articles/**/*").select { |v| v.end_with?(".md") }

    article_paths.each do |path|
      md = DevcastMarkdown.parse_from(path)
      article = Article.find_or_initialize_by(slug: md.slug)
      next if article.md5 == md.md5

      article.attributes = {
        title: md.title,
        repo_name: repo_name,
        md5: md.md5,
        lead_content: md.lead_content,
        content: md.content,
        published_at: md.published_at || article.published_at || Time.current
      }
      article.set_categories(md.categories)
      article.set_tags(md.tags)

      if article.valid?
        article.save
      else
        Rails.logger.warn("Cannot save or update article #{repo_name}/#{article.slug}")
      end
    end
  end
end
