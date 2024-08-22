class Booking < ApplicationRecord
  belongs_to :customer
  belongs_to :workshop

  after_create :update_seats

  def update_seats
    workshop = Workshop.find_by(id: workshop_id)
    workshop.update(remaining_seats: workshop.total_seats - no_of_tickets)
  end
end
