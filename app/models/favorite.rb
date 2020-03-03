class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :product
  validates_uniqueness_of :user, scope: :product
end
