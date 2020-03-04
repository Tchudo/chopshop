class Stock < ApplicationRecord

  belongs_to :shop
  belongs_to :product
  has_many :reviews, dependent: :destroy
  has_many :baskets, dependent: :destroy


end
