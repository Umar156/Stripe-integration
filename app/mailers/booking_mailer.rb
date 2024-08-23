require "rqrcode"
class BookingMailer < ApplicationMailer
  def notify_owner(booking)
    # used for qr code in mail
    qrcode = RQRCode::QRCode.new(booking_root_url(booking.id))
    @svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
    # end for qr code 
    @booking = booking
    @customer = @booking.customer
    mail(to: ENV['EMAIL_TO'], cc: @customer.email, subject: 'Booking Confirmation')
  end

  def booking_root_url(booking_id)
    if Rails.env.development?
      "http://localhost:3000/bookings/#{booking_id}/booking_details"
    else
      # ToDO in future
    end
  end
end