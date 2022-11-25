module Api 
    module V1
            class HomeController < ApiController
                before_action :authenticate_user!
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


                def like  
                    if current_user != 'merchant'
                        product = Product.find_by(id: params[:home_id])
                        # byebug
                        if current_user.likes.where(likeable_id: params[:home_id], likeable_type: "Product").present?
                            like = product.likes.find_by(likeable_id: params[:home_id])
                            like.destroy
                            render json: {meta: {message: 'Product deleted from wishlist...'}}
                        else
                            like = product.likes.new(user_id: current_user.id)
                            if like.save
                                render json: {meta: {message: 'Product added to wishlist...'}}
                            end        
                        end
                    else
                        render json: {message: 'not authorised'}
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
                    if current_user.user_type != "merchant"
                        cart = Cart.find_or_create_by(user_id: current_user.id)
                        if cart.present?
                           product = Product.find_by(id: params[:home_id])
                           if product != nil

                                if cart.cart_items.find_by(product_id: product.id).present?
                                    return render json: {meta: {message: 'prodct is already in cart'}}
                                end
                               
                               cart_item = cart.cart_items.new(product_id: product.id, total_price: product.price, product_quantity: 1)

                                    if cart_item.save
                                        render json: {meta: {message: 'Product added to cart...'}}
                                    end
                            else
                                render json: {meta: {message: 'Product not found'}}
                            end
                        end
                    else
                        render json: {message: "you are not authorised"}
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

