# == Schema Information
#
# Table name: tags
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  article_tags_count :integer          default(0), not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Tag < ApplicationRecord
  # Relations
  has_many :article_tags
  has_many :articles, through: :article_tags

  # Validations
  validates :name, presence: true, length: { maximum: 255 }

  # Callbacks

  # Scopes
  scope :active, -> do
    cond = Tag.arel_table[:article_tags_count].gt(0)
    where(cond)
  end

  # Methods
end
