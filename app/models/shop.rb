class Shop < ApplicationRecord
  belongs_to :user
  has_many :stocks
  has_many :time_tables
  has_many :products, through: :stocks

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # validates address, presence: true
  # validates user_id, presence: true
end
