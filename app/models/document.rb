class Document < ApplicationRecord
  mount_uploader :aplication, AplicationUploader
  validates :aplication, file_size: { less_than: 10.megabytes, message: 'size should be under 10 megabytes'  }
  has_rich_text :title
end
