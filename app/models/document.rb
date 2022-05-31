class Document < ApplicationRecord
  mount_uploader :aplication, AplicationUploader
  validates :aplication, file_size: { less_than: 20.megabytes, message: 'size should be under 20 megabytes'  }
  has_rich_text :title
end
