module Api
	module V1
		class CartsController < ApiController
                before_action :authenticate_user!

			  def index
			  		if current_user.user_type != "merchant"
				        @carts = current_user.cart
				        @cart_item = current_user.cart.cart_items if @carts.present?
				        @addresses = current_user.addresses
				        render json: {cart_item: @cart_item, cart: @carts, meta: {message: 'cart items in cart'}}
				    else
				    	render json: {meta: {message: 'not authorised'}}
			    	end
			  end

			  def destroy_cart_item
			  	if current_user.present?
				    @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
				    if @cart_item.present?
				       @cart_item.destroy
				       render json: {data: @cart_item, meta: {message: 'cart item deleted'}}
				    else
				    	render json: {meta: {message: 'cart item already deleted'}}
				    end
				end
			  end

			  def update_cart
			  	if current_user.present?
				    cart_item = CartItem.find_by(id: params[:cart_id])
				    # byebug
				    pro_price = cart_item.product.price  
				    up_quantity = cart_item.update(product_quantity: params[:product_quantity].to_i, total_price: params[:product_quantity].to_i * pro_price)
				    render json:{data: up_quantity, meta: {message: 'cart item updated'} } 
				end
			  end


			private
			    def cart_item_params
			      # byebug
			      params.require(:cart).permit(:product_id, :cart_id, :total_price, :product_quantity, :destroy)
			    end
		end
	end
end