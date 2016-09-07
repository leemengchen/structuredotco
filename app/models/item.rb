class Item < ApplicationRecord
  has_paper_trail
  belongs_to :category
  has_many :ordered_items
  has_many :orders, through: :ordered_items
  mount_uploader :image, ImageUploader
  searchkick word_start: [:title , :description]

  after_save :reindex_item


  def reindex_item
    reindex
  end
end
