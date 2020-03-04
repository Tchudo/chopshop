class Product < ApplicationRecord
  #searchkick  #ElasticSearch

  belongs_to :category
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :favorites
  has_many :stocks, dependent: :destroy
  has_many :shops, through: :stocks
  has_one_attached :photo



  validates :name, presence: true
  # validates :product_sku, uniqueness: true


  # def search_data  #ElasticSearch
  #   attributes.merge(shops: self.shops.map(&:name), addresses: self.shops.map(&:address), tags: self.tags.map(&:label) )
  # end


  # def self.searchable_by(words)
  #   if words.blank?
  #     products = []
  #   else
  #     products = Product.all
  #     words.split(" ").each do |word|
  #       products = products.where(id: products.search(word).map(&:id))
  #     end
  #   end
  #   return products
  # end

end
