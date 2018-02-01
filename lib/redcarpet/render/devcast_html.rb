require "rouge/plugins/redcarpet"

class Redcarpet::Render::DevcastHtml < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def initialize(opts = {})
    super
    @anchors = []
    @repo_name = opts[:repo_name]
  end

  def header(text, level)
    number = 2
    anchor = text.downcase.gsub(' ', '-')

    while @anchors.include?(anchor)
      if number > 2
        anchor[-1] = number.to_s
      else
        anchor += "-#{number}"
      end

      number += 1
    end

    @anchors << anchor

    %(<h#{level + 1} id="#{anchor}">#{text}</h#{level + 1}>)
  end

  def image(link, title, alt_text)
    image_link = replace_internal_image_link(link)
    <<-EOS.strip_heredoc
      <div class="article-container__image-container">
        <a href="#{image_link}" target="_blank" rel="noopener noreferrer">
          <img src="#{image_link}" alt="#{alt_text}" title="#{title}" class="img-responsive" />
        </a>
      </div>
    EOS
  end

  private

  def replace_internal_image_link(link)
    return link if link.start_with?("http")

    path = link.split("/images/")[1..-1].join("")
    "/images/#{@repo_name}/images/#{path}"
  end
end