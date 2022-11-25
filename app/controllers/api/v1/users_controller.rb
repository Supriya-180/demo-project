module Api
	module V1
	class UsersController < ApiController
		  before_action :authenticate_user!, except: :create
		  before_action :account_activated!, except: [:create, :otp_varify, :otp_varify_email]
		  before_action :find_user, except: %i[create index]

		  # GET /users
		  def index
		    @users = User.all
		    render json: @users
		  end


		  # GET /users/{username}
		  def show
		    render json: current_user
		  end


		  # POST /users
		  # def create
		  #   @user = User.new(user_params)
		  #   if @user.save
		  #     render json: @user, status: :created
		  #   else
		  #     render json: { errors: @user.errors.full_messages },
		  #            status: :unprocessable_entity
		  #   end
		  # end


		  # PUT /users/{username}
		  def update
		  	# byebug
		    unless @user.update(update_params)
		      render json: { errors: @user.errors.full_messages },
		             status: :unprocessable_entity
		      else
		      	render json: @user, status: :created
		    end
		  end


		  # DELETE /users/{username}
		  def destroy
		    if @user.destroy
		 	 	render json: {meta: "user deleted"}
	       else
				render json: {errors: "user not deleted"}
			 end
		  end


		def otp_varify
			user = User.find_by(phone_number: params[:phone_number])
			render json: {message: 'user not found'} unless user.present?
			otp = SmsOtp.where(phone_number: user.phone_number).last
			unless otp.valid_until > Time.now 
				return render json: {message: 'otp expired'}
			end
			
			if otp.pin == params[:otp].to_i 
				otp.update(activate: true)
				user.update(activate: true)
			# byebug
				UserMailer.welcome_email(user).deliver_now
				render json: {message: 'Successfully varified'}
			else
				render json: {message: 'otp not valid'}
			end
			
		end


		def otp_varify_email
			user = User.find_by(email: params[:email])
			render json: {message: 'user not found'} unless user.present?
			otp = EmailOtp.where(email: user.email).last
			# byebug
			unless otp.valid_until > Time.now 
				return render json: {message: 'otp expired'}
			end
			if otp.pin == params[:otp].to_i 
				otp.update(activate: true)
				user.update(activate: true)
				render json: {message: 'Successfully varified by email'}
			else
				render json: {message: 'otp not valid'}
			end
		end


		  private


	  def user_params
	    params.permit(:name, :user_name, :email, :password)
	  end
	
	def update_params
	   	params.require(:user).permit(:name, :password)
	   end

	   # def delete_params
	   # 	params.require(:user).permit(:name)
	   # end

	  def find_user
	    @user = User.find_by_id(params[:id])
	  end
	end

	end
end



