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
end
