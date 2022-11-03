class WishlistsController < ApplicationController

	def index

		
		#@wishlists = current_user.likes
		wishlists=current_user.likes.where(likeable_type: "Product").pluck(:likeable_id).uniq
		@products = Product.where(id: wishlists)
		@likes = current_user.likes.find_by(id: params[:id])
        
	end

    def destroy
    	@like = current_user.likes.find_by(likeable_id: params[:id],likeable_type: "Product")
    	@like.destroy
    	redirect_to home_index_path
	end

end


