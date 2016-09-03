class Order < ApplicationRecord
  has_many :ordered_items
  has_many :items, through: :ordered_items
  belongs_to :user
  enum status: { pending: 0, paid: 1, failed: 2 }
end
