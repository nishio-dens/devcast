# == Schema Information
#
# Table name: header_categories
#
#  id            :integer          not null, primary key
#  category_id   :integer          not null
#  display_order :integer          default(0), not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class HeaderCategory < ApplicationRecord
  # Relations
  belongs_to :category

  # Validations

  # Callbacks

  # Delegates
  delegate :name, to: :category

  # Scopes

  # Methods
end
