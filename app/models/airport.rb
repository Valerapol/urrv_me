class Airport < ApplicationRecord
  has_rich_text :description
  serialize :aip
  has_one_attached :logo
  validates :logo, attached: true, 
    content_type: ['image/png', 'image/jpg', 'image/jpeg'], 
    size: { less_than: 10.megabytes , message: 'size should be under 10 megabytes' }
end
