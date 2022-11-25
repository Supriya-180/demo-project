class ProductsController < ApplicationController

	  def show 
      @product = Product.find(params[:id])
      @pv = @product.product_variants
      @comments = Comment.where(product_id: params[:id])
    end

    def new 
      @product = current_user.products.new
    end

    def create
    	@product = current_user.products.new(product_params)
    	if @product.save
    		redirect_to home_index_path(@product.id)
    	else 
    		render 'new'
    	end
    end

    def edit
      # byebug
      @product = Product.find(params[:id])
    end
    

    def like
      # byebug
      comment = Comment.find_by(id: params[:product_id]) 
      if current_user.likes.where(likeable_id: params[:product_id], likeable_type: "Comment").present?
        # byebug
        like = comment.likes.find_by(user_id: current_user.id)
        like.destroy
          # byebug
        comment=Comment.find_by(params[:id])
        product = comment.product_id
        redirect_to product_path(product)
      else
        like = comment.likes.new(user_id: current_user.id)
        if like.save
          comment=Comment.find_by(params[:id])
          product = comment.product_id
          redirect_to product_path(product)
        end
      end
    end

    def update
      # byebug
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to @product
      else
        render :edit 
      end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to home_index_path
    end

    def options_for_variant
      variant = Variant.find_by(id: params[:id])
      @variant_attributes = variant.variant_attributes
    end

    private
    def product_params
      # byebug
      params.require(:product).permit(:category_id, :name, :price, :manufacturing_date, :image, 
        product_variants_attributes: [:id, :variant_id, :variant_attribute_id, :_destroy])
    end
end


