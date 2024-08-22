class BookingsController < ApplicationController
  def create
    @workshop = Workshop.find_by(id: params[:workshop_id])
    @customer = Customer.find_by(email: params[:email])
    unless @customer.present?
      @customer = Customer.new(customer_params)
      @customer.save!
    end
    @stripe_service = StripeService.new
    @stripe_customer = @stripe_service.find_or_create_customer(@customer)
    @card = @stripe_service.create_source(@stripe_customer.id, params[:stripeToken])
    @amount_paid = params[:no_of_tickets].to_i * @workshop.registration_fee
    @charge = @stripe_service.create_charge(@amount_paid, @stripe_customer.id, @card.id, @workshop.name)
    @booking = @workshop.bookings.new(no_of_tickets: params[:no_of_tickets], amount_paid: @amount_paid, stripe_transaction_id: @charge.id, customer_id: @customer.id)
    @booking.save!
    redirect_to workshop_path(@workshop), alert: 'Your ticket has been booked!'
  rescue Stripe::StripeError => e
    redirect_to workshop_path(@workshop), alert: "#{e.message}"
  end

  private

  def customer_params
    params.permit(:name, :email)
  end
end
