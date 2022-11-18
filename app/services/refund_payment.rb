class RefundPayment
  require "razorpay"
  Razorpay.setup('rzp_test_sGKFWWIENwCHjV', 'EX65NY1GAg5e6mTzJGJmoBE6')

  # attr_accessor :order

  def initialize order
    # byebug
    @order = order
  end

  def refund_payment
      paymentId = @order.razorpay_payment_id 

      para_attr = {
        "amount": @order.total_price,
        "speed": "normal"
      }
      response = Razorpay::Payment.fetch(paymentId).refund(para_attr) 
  end


end

