module Api 
    module V1

        class ProductsController < ApiController

        	  def show 
              @product = Product.find(params[:id])
              @pv = @product.product_variants
              @comments = Comment.where(product_id: params[:id])
              render json: @product
            end

            def new 
              @product = current_user.products.new
              render json: @product
            end

            def create
            	@product = current_user.products.new(product_params)
            	if @product.save
            		render json: @product
            	else 
            		render json: @product
            	end
            end

            def edit
              # byebug
              @product = Product.find(params[:id])
            end

            def update
              # byebug
              @product = Product.find(params[:id])
              if @product.update(product_params)
                render json: @product
              else
                render json: @product 
              end
            end

            def destroy
                @product = Product.find(params[:id])
                @product.destroy
                render json: @product
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
    end
end