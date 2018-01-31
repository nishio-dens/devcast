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

class Article < ApplicationRecord
  extend FriendlyId
  friendly_id :slug

  # Relations
  has_many :article_categories, dependent: :destroy
  has_many :categories, through: :article_categories
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

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

  # Methods

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
        self.association(:tags).add_to_target(tag)
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
        self.association(:categories).add_to_target(category)
      else
        self.categories.build(name: name)
      end
    end
  end
end
