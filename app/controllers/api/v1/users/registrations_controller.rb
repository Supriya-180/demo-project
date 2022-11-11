class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :sign_up_params, only: [:create]
    # before_action :configure_permitted_parameters, if :devise_controller?

    def create
      build_resource(sign_up_params)   # resource = User.new(sign_up_params)
      # byebug
      if resource.save
        token = resource.generate_jwt
        # byebug
        # render resource.merge(meta: { message: 'Sign up success', token: token })
        render :json => {user: serialized_user(resource), meta: { message: 'Sign up success', token: token }}, :status => :created
      else
        render json: { errors: resource.errors.full_messages }, :status => :unprocessable_entity
      end

    end

    private

    def serialized_user resource
      Api::V1::UserSerializer.new(resource).as_json
    end

  protected
   def sign_up_params
    # byebug
      params.require(:user).permit(:email, :password,:name,:gender,:user_type,:phone_number)
   end
end
    
