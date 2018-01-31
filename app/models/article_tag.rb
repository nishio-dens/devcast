# == Schema Information
#
# Table name: article_tags
#
#  id         :integer          not null, primary key
#  article_id :integer          not null
#  tag_id     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ArticleTag < ApplicationRecord
  counter_culture [:tag]

  # Relations
  belongs_to :article
  belongs_to :tag

  # Validations

  # Callbacks

  # Scopes

  # Methods
end
