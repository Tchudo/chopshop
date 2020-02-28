class Shop < ApplicationRecord


  belongs_to :user
  has_many :stocks, dependent: :destroy
  has_many :time_tables
  has_many :products, through: :stocks
  has_one_attached :photo


  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  # validates address, presence: true
  # validates user_id, presence: true





end
