module MarkdownHelper
  def devcast_markdown_content_toc(lead_html, content_html)
    htexts = Oga
               .parse_html(lead_html + content_html)
               .children
               .select { |v| v.is_a? Oga::XML::Element }
               .select { |v| %w(h2 h3).include?(v.name) }
    parent = nil
    htexts_with_parent = htexts.map do |ht|
      if ht.name == "h2"
        parent = ht
        [ht, nil]
      else
        [ht, parent]
      end
    end
    htexts_with_children = htexts_with_parent.select { |c, p| p.nil? }.map do |n, _|
      {
        node: n,
        children: htexts_with_parent.select { |c2, p2| p2 == n }.map { |n, _| n }
      }
    end
    if htexts_with_children.present?
      html = <<-EOS.strip_heredoc
      <ul>
        #{
      htexts_with_children.map do |n|
        c = "<li><a href=\"##{n[:node].get('id')}\">#{n[:node].text}</a></li>"
        if n[:children].present?
          c += "<ul>"
          c += n[:children].map do |n2|
            "<li><a href=\"##{n2.get('id')}\">#{n2.text}</a></li>"
          end.join("\n")
          c += "</ul>"
          c
        else
          c
        end
      end.join("\n")
      }
      </ul>
      EOS
      html.html_safe
    else
      ""
    end
  end
end