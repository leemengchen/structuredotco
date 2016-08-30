class Order < ApplicationRecord
  has_many :ordered_items
  has_many :items, through: :ordered_items
  belongs_to :user
end
