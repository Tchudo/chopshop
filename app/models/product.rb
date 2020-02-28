class Product < ApplicationRecord
  # searchkick


  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :favorites
  has_many :stocks
  has_many :shops, through: :stocks
  has_one_attached :photo



  validates :name, presence: true
  # validates :product_sku, uniqueness: true

  # def search_data
  #   attributes.merge(shops: self.shops.map(&:name).to_s, addresses: self.shops.map(&:address).to_s, tags: self.tags.map(&:label).to_s )
  # end


end
