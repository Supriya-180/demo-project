class CartsController < ApplicationController

  def index
        @carts = current_user.cart
        @cart_item = current_user.cart.cart_items if @carts.present?
        @addresses = current_user.addresses
  end

  def destroy_cart_item
    @cart_item = current_user.cart.cart_items.find_by(id: params[:id])
    if @cart_item.present?
       @cart_item.destroy
    end
    redirect_to carts_path
  end

  def update_cart
    cart_item = CartItem.find_by(id: params[:cart_id])
    pro_price = cart_item.product.price  
    up_quantity = cart_item.update(product_quantity: params[:product_quantity].to_i, total_price: params[:product_quantity].to_i * pro_price)
    redirect_to carts_path
  end


private
    def cart_item_params
      # byebug
      params.require(:cart).permit(:product_id, :cart_id, :total_price, :product_quantity, :destroy)
    end
end




