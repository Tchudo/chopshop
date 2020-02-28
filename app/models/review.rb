class Review < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  validates :comment, presence: true, length: { maximum: 80 }
  validates :rating, inclusion: { in: 0..5, message: "La note doit être inclut entre 1 et 5" }
end
