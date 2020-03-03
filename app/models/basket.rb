class Basket < ApplicationRecord
  belongs_to :user
  belongs_to :stock
  validates_uniqueness_of :user, scope: :stock
end
