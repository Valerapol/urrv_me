class Event < ApplicationRecord
  validates :title, :body, presence: true
  has_rich_text :body
  has_rich_text :body_en
end
