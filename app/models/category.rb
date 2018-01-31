# == Schema Information
#
# Table name: categories
#
#  id                       :integer          not null, primary key
#  name                     :string(255)      not null
#  article_categories_count :integer          default(0), not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

class Category < ApplicationRecord
  # Relations
  has_many :article_categories
  has_many :articles, through: :article_categories

  # Validations
  validates :name, presence: true, length: { maximum: 255 }

  # Callbacks

  # Scopes
  scope :active, -> do
    cond = Category.arel_table[:article_category_count].gt(0)
    where(cond)
  end

  # Methods
end
