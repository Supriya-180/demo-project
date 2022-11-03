# module API
#   module V1
          class Api::V1::Users::SessionsController < Devise::SessionsController
            
            respond_to :json
            skip_before_action :verify_authenticity_token, :only => :create
            
            def create
              # byebug
              user = User.find_by_email(params[:user][:email])    # user = User.find_by_email(sign_in_params[:email])



              if user && user.valid_password?(params[:user][:password])
                token = user.generate_jwt
                render :json => {meta: { message: 'Successfully sign in...', token: token }}
              else
                render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
              end
            end

          # protected
          #  def sign_in_params
          #   # byebug
          #     params.require(:user).permit(:email, :password)
          #  end

          end
   
#   end
# end