class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :workshop

  after_create : update_seats

  def update_seats
    Workshop.update(remaining_seats: Workshop.total_seats - no_of_tickets)
  end
end
