# == Schema Information
#
# Table name: article_categories
#
#  id          :integer          not null, primary key
#  article_id  :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ArticleCategory < ApplicationRecord
  counter_culture [:category]

  # Relations
  belongs_to :article
  belongs_to :category

  # Validations

  # Callbacks

  # Scopes

  # Methods
end
