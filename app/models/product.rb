class Product < ApplicationRecord
  has_many :product_tags
  has_many :tags, through: :product_tags
  has_many :favorites
  has_many :stocks
  has_many :shops, through: :stocks

  validates name, presence: true
  validates product_sku, uniqueness: true,

end
