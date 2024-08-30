require 'stripe'

class StripeService
  Stripe.api_key = ENV['STRIPE_SECRET_KEY']
  def initialize()
  end

  def find_or_create_customer(customer)
    if customer.stripe_customer_id.present?
      stripe_customer = Stripe::Customer.retrieve(customer.stripe_customer_id)
    else
      stripe_customer = Stripe::Customer.create(email: customer.email, name: customer.name)
      customer.update!(stripe_customer_id: stripe_customer.id)
    end
    stripe_customer
  end

  def create_source(stripe_customer, token)
    source = Stripe::Customer.create_source(stripe_customer, {source: token})
  end

  def create_charge(amount_paid, customer_id, card, workshop_name)
    Stripe::Charge.create({
        amount: (amount_paid * 100).to_i,
        currency: 'usd',
        customer: customer_id,
        source: card,
        description: "Amount #{amount_paid} charged for #{workshop_name}"
    })
  end


  # for monthly or yearly subscription
  def create_subscription(stripe_customer_id, plan_id)
    Stripe::Subscription.create({
      customer: stripe_customer_id,
      items: [{ plan: plan_id }]
    })
  end
end