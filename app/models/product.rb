class Product < ApplicationRecord
  #searchkick "Elastic"

  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :favorites
  has_many :stocks
  has_many :shops, through: :stocks
  has_one_attached :photo


  validates :name, presence: true
  # validates :product_sku, uniqueness: true


end
