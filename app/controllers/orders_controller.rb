class OrdersController < ApplicationController
   respond_to :js, :json, :html
	# def new 
 #    	@order = current_user.products.new
 #    end
   Razorpay.setup('rzp_test_sGKFWWIENwCHjV', 'EX65NY1GAg5e6mTzJGJmoBE6')

 	def index
 		@order_items = current_user.order_items
      @orders = current_user.orders
   end

   def show_order_item
      # byebug
      @order_item = OrderItem.find(params[:id])
      @order_items = current_user.order_items.where.not(id: @order_item.id)
      @address = @order_item.order.address
   end

   def update
      order = Order.find_by(id: params[:id])
      if order.present?
         payment_response = {razorpay_order_id: params[:razorpay_order_id], razorpay_payment_id: params[:razorpay_payment_id], razorpay_signature: params[:razorpay_signature] }
         verify_result = Razorpay::Utility.verify_payment_signature(payment_response)
         if verify_result
            order.update(razorpay_payment_id: params[:razorpay_payment_id], status: "paymentcompleted") #status payment_completed
         else
            flash[:error] = "something went wrong!!!" 
            redirect_to orders_path
         end
      end
   end
   

   def cancel_order
      # byebug
      @order = Order.find(params[:id])
      @order.update(status: "cancelled")    #status canceled 
      redirect_to orders_path
   end

   def place_order
      # byebug 
      if params[:address_id].present? 
         cart = current_user.cart
         if cart.present? and cart.cart_items.present? 
            # byebug
            price = cart.total_price * 100
            @order = current_user.orders.new(total_price: price.to_i,total_quantity: cart.total_quantity, address_id: params[:address_id].to_i)
            cart.cart_items.each do |orderitem|
              @order_item = @order.order_items.new(product_id: orderitem.product_id, total_price: orderitem.total_price, product_quantity: orderitem.product_quantity)
            end

            if @order.save
               cart.cart_items.delete_all 
               cart.update(total_price: 0, total_quantity: 0)
               # cart.cart_items.destroy 
               order = Razorpay::Order.create(amount: price.to_i, currency: 'INR', receipt: 'TEST')
               # order = Razorpay::Order.create amount: price.to_i, currency: 'INR', receipt: 'TEST'
               @order.update(razorpay_order_id: order.id) #status created
               redirect_to pay_order_path(@order.id)
            end
         else
            redirect_to orders_path
         
         end
      else
         flash[:error] = "please select delivery address or create new!!" 
         redirect_to carts_path
      end
   end

   def pay
      # byebug
      @order = Order.find_by(id: params[:id])
      @cart = current_user.cart
   end


end
