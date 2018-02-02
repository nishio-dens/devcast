SitemapGenerator::Sitemap.default_host = "https://dev.densan-labs.net"

SitemapGenerator::Sitemap.create do
  add '/', priority: 1.0, changefreq: 'daily'
  add '/articles', priority: 0.9, changefreq: 'daily'

  Article.published.all.find_each do |cr|
    add article_path(cr), priority: 0.5, changefreq: 'weekly'
  end
end
