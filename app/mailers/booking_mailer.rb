class BookingMailer < ApplicationMailer
  def notify_owner(booking)
    @booking = booking
    @customer = @booking.customer
    mail(to: ENV['EMAIL_TO'], cc: @customer.email, subject: 'Booking Confirmation')
  end
end