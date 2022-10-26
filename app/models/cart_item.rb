class CartItem < ApplicationRecord
	belongs_to :product
	belongs_to :cart

    after_save :add_product
    after_destroy :add_product

    def add_product
		self.cart.update(total_price: self.cart.cart_items.sum(:total_price), 
			             total_quantity: self.cart.cart_items.sum(:product_quantity))
    end


end
