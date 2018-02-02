xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "WebCast"
    xml.description "DevCastはWeb関連の技術をまとめたブログです。"
    xml.link "https://dev.densan-labs.net"

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description do
          xml.cdata!(article.lead_html)
        end
        article.categories.each do |category|
          xml.category category.name
        end
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link "#{request.protocol}#{request.host_with_port}#{article_path(article)}"
        xml.guid "#{request.protocol}#{request.host_with_port}#{article_path(article)}"
      end
    end
  end
end