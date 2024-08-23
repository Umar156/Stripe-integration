class Workshop < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :customers, through: :bookings
end
