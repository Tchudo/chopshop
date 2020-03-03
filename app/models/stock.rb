class Stock < ApplicationRecord

  belongs_to :shop
  belongs_to :product
  has_many :reviews
  has_many :baskets


end
