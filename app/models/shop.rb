class Shop < ApplicationRecord
  belongs_to :user
  has_many :stocks
  has_many :time_tables
  has_many :products, through: :stocks

  # validates address, presence: true
  # validates user_id, presence: true
end
