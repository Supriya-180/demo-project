class OrderMailer < ApplicationMailer
	
	  def order_confirmed order
	  	# byebug
	    @order = order
	    @url  = 'http://localhost:3000/api/v1/users'
	    if @order.status == 'created'
	   		mail(to: @order.id, subject: 'Order created...')
	   	end

	    if @order.status == 'paymentcompleted'
	   		mail(to: @order.id, subject: 'Ordered Successfully')
	   	end

	  end
end
