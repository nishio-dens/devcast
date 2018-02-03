# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  published    :boolean          default(FALSE), not null
#  slug         :string(255)      not null
#  title        :string(255)      not null
#  repo_name    :string(512)      not null
#  md5          :string(32)       not null
#  lead_content :text(16777215)
#  content      :text(16777215)
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require "#{Rails.root}/lib/redcarpet/render/devcast_html"

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :slug

  # Relations
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  accepts_nested_attributes_for :categories
  accepts_nested_attributes_for :tags

  # Validations
  validates :slug,
    presence: true,
    length: { maximum: 255 }
  validates :title,
    presence: true,
    length: { maximum: 255 }
  validates :repo_name,
    presence: true,
    length: { maximum: 512 }
  validates :md5,
    presence: true,
    length: { maximum: 32 }

  # Callbacks

  # Scopes
  scope :published, -> do
    where(published: true)
  end

  # Methods

  def related_articles(limit: 5)
    category_ids = self.article_categories.pluck(:category_id)
    Article
      .published
      .joins(:article_categories)
      .where(article_categories: { category_id: category_ids })
      .order(published_at: :desc)
      .distinct
      .limit(limit)
  end

  def next_article
    Article
      .published
      .where(Article.arel_table[:id].gt(self.id))
      .order(published_at: :asc)
      .first
  end

  def prev_article
    Article
      .published
      .where(Article.arel_table[:id].lt(self.id))
      .order(published_at: :desc)
      .first
  end

  def active_tags
    self.tags.reject(&:_destroy)
  end

  def active_categories
    self.categories.reject(&:_destroy)
  end

  def set_tags(tags)
    current_tags = self.tags.pluck(:name).map(&:strip)
    old_tags = (current_tags - tags)
    old_tags.each do |name|
      self.tags.find { |v| v.name == name }.mark_for_destruction
    end

    new_tags = (tags - current_tags)
    new_tags.each do |name|
      tag = Tag.find_by(name: name)
      if tag.present?
        self.article_tags.build(tag_id: tag.id)
      else
        self.tags.build(name: name)
      end
    end
  end

  def set_categories(categories)
    current_categories = self.categories.pluck(:name).map(&:strip)
    old_categories = (current_categories - categories)
    old_categories.each do |name|
      self.categories.find { |v| v.name == name }.mark_for_destruction
    end

    new_categories = (categories - current_categories)
    new_categories.each do |name|
      category = Category.find_by(name: name)
      if category.present?
        self.article_categories.build(category_id: category.id)
      else
        self.categories.build(name: name)
      end
    end
  end

  def lead_html
    md = markdown_engine
    md.render(self.lead_content).html_safe
  end

  def content_html
    md = markdown_engine
    @content_html ||= md.render(self.content).html_safe
  end

  private

  def markdown_engine
    renderer = Redcarpet::Render::DevcastHtml.new(
      with_toc_data: true,
      hard_warp: true,
      repo_name: self.repo_name
    )
    @markdown_engine ||= Redcarpet::Markdown.new(
      renderer,
      tables: true,
      fenced_code_blocks: true
    )
  end
end
