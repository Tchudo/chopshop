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



def open?
  return false if close_today?
  today = self.time_tables.find_by(day_of_week: Time.now.wday)
  (today.opened_at...today.closed_at).include?(Time.now.hour)
end

private

def open_today?
  self.time_tables.map(&:day_of_week).include?(Time.now.day)
end

def close_today?
  !self.open_today?
end


end
