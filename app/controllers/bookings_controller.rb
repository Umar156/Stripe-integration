class BookingsController < ApplicationController
  def create
    @workshop = Workshop.find_by(id: params[:workshop_id])
    @customer = Customer.find_or_initialize_by(email: params[:email])
    @customer.update!(customer_params) if @customer.new_record?
    
    @stripe_service = StripeService.new
    @stripe_customer = @stripe_service.find_or_create_customer(@customer)
    @card = @stripe_service.create_source(@stripe_customer.id, params[:stripeToken])

    if params[:subscription_plan].present?
      @subscription = @stripe_service.create_subscription(@stripe_customer.id, params[:subscription_plan])
      price_object = @subscription[:items][:data].first[:price]
      unit_amount = price_object[:unit_amount]
      amount_in_dollars = unit_amount / 100.0
      @booking = @workshop.bookings.new(
        no_of_tickets: params[:no_of_tickets],
        amount_paid: amount_in_dollars, 
        stripe_transaction_id: @subscription.id, 
        customer_id: @customer.id
      )
    else
      @amount_paid = params[:no_of_tickets].to_i * @workshop.registration_fee
      @charge = @stripe_service.create_charge(@amount_paid, @stripe_customer.id, @card.id, @workshop.name)
      @booking = @workshop.bookings.new(
        no_of_tickets: params[:no_of_tickets], 
        amount_paid: @amount_paid, 
        stripe_transaction_id: @charge.id, 
        customer_id: @customer.id
      )
    end

    @booking.save!
    BookingMailer.notify_owner(@booking).deliver_now
    redirect_to workshop_path(@workshop), notice: 'Your ticket has been booked!'
  rescue Stripe::StripeError => e
    redirect_to workshop_path(@workshop), notice: "#{e.message}"
  end

  private

  def customer_params
    params.permit(:name, :email)
  end
end
