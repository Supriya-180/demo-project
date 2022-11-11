class CommentsController < ApplicationController
	def index

	end

	def new
		@comment = current_user.comments.new
	end


	def create
		@comment = current_user.comments.new(comment_Params)
		if @comment.save
			# byebug
			@product = Product.find_by_id(params[:product_id])
			redirect_to product_path(@product)
		else
		# byebug
			flash[:message]="please add comment"
		end
	end

	def show
		@comment = Comment.where(product_id: params[:id])

	end

    def comment_Params
      params.require(:comment).permit(:user_id, :product_id, :description, :reply_id)
    end
end
