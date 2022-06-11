class Event < ApplicationRecord
  validates :title, :body, presence: true
  validates_datetime :start_time, on_or_after: lambda { Time.now }, allow_nil: true
  validates_datetime :end_time, allow_nil: true, after: :start_time

  has_rich_text :body
  has_rich_text :body_en
end
