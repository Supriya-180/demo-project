class OrderMailer < ApplicationMailer
	
	  def order_confirmed order
	  	# byebug
	    @order = order
	    	# byebug
	    	attachments["order_invoice_#{@order.id}.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(template: '/orders/invoice.html.erb', layout: false))
	   		mail(to: 'supriyas@witmates.com', subject: 'Ordered Successfully')
	  end
end
