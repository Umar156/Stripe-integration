class Customer < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :workshops, through: :bookings
end
