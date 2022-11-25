module Api
	module V1

			class CommentsController < ApiController

                before_action :authenticate_user!

				def create
					@product = Product.find_by_id(params[:product_id])
					@comment = current_user.comments.new(comment_Params)
					@comment.product_id = @product.id
					# byebug
					if @comment.save
						render json: @comment
					else
						render json: {meta: {message: 'not able to comment'}}
					end
				end

			    def comment_Params
			      params.require(:comment).permit(:user_id, :product_id, :description, :reply_id)
			    end
			end

	end
end
