module Api 
    module V1

        class ProductsController < ApiController
              def index
                # byebug
                if current_user.user_type == "merchant"
                    @products = current_user.products
                    render json: @products

                else
                    @products = Product.all
                    render json: @products
                end
              end


        	  def show 
              if current_user.user_type == "merchant"
                # byebug
                @product = current_user.products.find_by_id(params[:id])
              else
                @product = Product.find(params[:id])

              end
              render json: @product
            end

            def create
              # byebug
              if current_user.user_type == "merchant"
              	@product = current_user.products.new(product_params)
              	if @product.save
              		# render json: @product  
                  render json: {data: serilized_product(@product), meta: { message: 'Product added' }}

                  # image = @product.image.present? ? Rails.application.routes.url_helpers.rails_blob_url(@product.image) : nil
                  # render json: @product.as_json.merge(image: image)
              	else 
              		render json: {errors: @product.errors.full_messages}
              	end
              else
                render json: {errors: "not authorised"}
              end
            end


            def serilized_product product
              Api::V1::ProductSerializer.new(product)
            end


            # def edit
            #   # byebug
            #   @product = Product.find(params[:id])
            # end

            def update
              if current_user.user_type == "merchant"
                  @product = current_user.products.find(params[:id])
                  if @product.update(product_params)
                    render json: {data: @product, meta: { message: 'Product updated' }}
                  else
                    render json: {errors: @product.errors.full_messages} 
                  end
              else
                render json: {errors: "not authorised"}
              end
            end

            def destroy
              if current_user.user_type == "merchant"
                # byebug
                  @product = current_user.products.find_by_id(params[:id])
                  if @product.present?
                    @product.destroy
                    render json: {data: @product, meta: {message: 'prodct Deleted'}}
                  else
                    render json: {meta: { message: 'Product not found' } }
                  end
                else
                  render json: {meta: {message: 'not authorised'}}
              end
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

                


# Rails.application.routes.url_helpers.rails_blob_url(Product.last.image)#, only_path: true)