module Api 
    module V1
            class HomeController < ApiController
                def index
                    byebug
                    if current_user.user_type == "merchant"
                        @products = current_user.products
                        render json: @products

                    else
                        @products = Product.all
                        render json: @products
                    end
                end


                def like  
                    product = Product.find_by(id: params[:home_id])
                    # byebug
                    if current_user.likes.where(likeable_id: params[:home_id], likeable_type: "Product").present?
                        like = product.likes.find_by(likeable_id: params[:home_id])
                        like.destroy
                        flash[:wishlist] = "Product deleted from wishlist..."
                        redirect_to home_index_path
                    else
                        like = product.likes.new(user_id: current_user.id)
                        if like.save
                            flash[:wishlist] = "Product added to wishlist..."
                            redirect_to home_index_path
                        end        
                    end
                end


                def show
                    @wishlist = Like.find_by(params[:id])
                    @product = Product.find(params[:id])
                    @pv = @product.product_variants
                    @comment = current_user.comments.find_by(product_id: params[:product_id])
                    render json: @product
                end
                    

                def add_to_cart
                    cart = Cart.find_or_create_by(user_id: current_user.id)
                    if cart.present?
                       product = Product.find_by(id: params[:home_id])
                       if cart.cart_items.find_by(product_id: product.id).present?
                            flash[:message]="Product is already in cart" 
                            redirect_to home_index_path
                            return
                        end
                       cart_item = cart.cart_items.new(product_id: product.id, total_price: product.price, product_quantity: 1)

                       if cart_item.save
                            flash[:message] = "Product added to cart..."
                            redirect_to home_index_path
                       else
                            flash[:alert] = "product not saved!!"  
                       end

                    end
                end


            def product_params
                  # byebug
                  params.require(:product).permit(:category_id, :name, :price, :manufacturing_date, :image, 
                    product_variants_attributes: [:id, :variant_id, :variant_attribute_id, :_destroy])
            end

        end
    end
end

