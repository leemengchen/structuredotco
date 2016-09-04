class Category < ApplicationRecord
  has_many :items
  mount_uploader :image, ImageUploader
end
