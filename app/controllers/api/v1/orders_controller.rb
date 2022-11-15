module Api
	module V1
		class OrdersController < ApiController
                before_action :authenticate_user!

			   respond_to :js, :json, :html
			   Razorpay.setup('rzp_test_sGKFWWIENwCHjV', 'EX65NY1GAg5e6mTzJGJmoBE6')

			   def index
			   		if current_user.user_type != "merchant"
				 		@order_items = current_user.order_items
				      	@orders = current_user.orders
				      	render json: @orders
			      		# render json: @order_items
			      	end
			   end

			   def show_order_item
			      # byebug
			      	@order_item = OrderItem.find(params[:id])
			      	@order_items = current_user.order_items.where.not(id: @order_item.id)
			      	@address = @order_item.order.address
			      	render json: @order_item
			   end

			   def update
			      # byebug
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
			      if params[:address_id].present? 
			         cart = current_user.cart
			         if cart.present? and cart.cart_items.present? 
			            # byebug
			            price = cart.total_price * 100
			            @order = current_user.orders.new(total_price: price.to_i,total_quantity: cart.total_quantity, address_id: params[:address_id].to_i)
			      		# byebug 
			            cart.cart_items.each do |orderitem|
			              @order_item = @order.order_items.new(product_id: orderitem.product_id, total_price: orderitem.total_price, product_quantity: orderitem.product_quantity)
			            end

			            if @order.save
			               	cart.cart_items.delete_all 
			               	cart.update(total_price: 0, total_quantity: 0)
			            	OrderMailer.order_confirmed(@order).deliver_now
			               	# cart.cart_items.destroy 
			               	order = Razorpay::Order.create(amount: price.to_i, currency: 'INR', receipt: 'TEST')
			               	# order = Razorpay::Order.create amount: price.to_i, currency: 'INR', receipt: 'TEST'
			               	@order.update(razorpay_order_id: order.id) #status created
			               	render json: {meta: {message: 'order placed'}}
			            end
			         else
			            render json: {meta:{message: 'nothing in cart'}}
			         
			         end
			      else
			         render json: {errors: 'please enter delivery address or create new!'}
			      end
			   end

			   def pay
			      	# byebug
			      	@order = Order.find_by(id: params[:id])
			      	@cart = current_user.cart
			   end

		end
	end
end