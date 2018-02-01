require "digest/md5"

class DevcastMarkdown
  include ActiveModel::Model

  attr_accessor :slug, :draft, :md5, :title, :lead_content,
    :content, :published_at, :categories, :tags

  def self.parse_from(file_path)
    md = self.new
    raw_content = open(file_path).read
    lead_content, content = md.split_lead_main_contents(raw_content)
    md.lead_content = lead_content
    md.content = content

    md.slug = file_path.split("/articles/")[-1].gsub("/", "-").split(".")[0]
    md.md5 = md.markdown_md5(raw_content)
    meta = md.parse_meta_from(file_path)
    md.draft = meta[:draft]
    md.title = meta[:title]
    md.published_at = meta[:published_at]
    md.categories = meta[:categories]
    md.tags = meta[:tags]
    md
  end

  def parse_meta_from(file_path)
    meta = YAML.load_file(file_path)
    return {} unless meta.present?

    {
      draft: meta["draft"] || false,
      title: meta["title"],
      published_at: meta["published_at"],
      categories: (meta["categories"] || "").split(",").map(&:strip),
      tags: (meta["tags"] || "").split(",").map(&:strip)
    }
  end

  def split_lead_main_contents(content)
    return "", "" unless content.present?

    removed_meta_content = content.split(/^---$/)[-1]
    c = removed_meta_content.split(/<!-- more -->/)
    if c.size >= 2
      [c[0].strip, c[1..-1].join("\n").strip]
    else
      ["", removed_meta_content]
    end
  end

  def markdown_md5(content)
    Digest::MD5.hexdigest(content)
  end
end
