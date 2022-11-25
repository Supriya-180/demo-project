class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
    respond_to :json
    skip_before_action :verify_authenticity_token, :only => :create
    before_action :sign_up_params, only: [:create]
    # before_action :configure_permitted_parameters, if :devise_controller?

    def create
      build_resource(sign_up_params)   # resource = User.new(sign_up_params)
      if resource.save
        otp = EmailOtp.create(email: resource.email, valid_until: Time.now + 2.minutes)
      # byebug
        otp1 = SmsOtp.create(phone_number: resource.phone_number, valid_until: Time.now + 4.minutes)
        token = resource.generate_jwt
        # otp = SmsOtp.where(phone_number: sign_up_params[:phone_number]).last
        # byebug
        # render resource.merge(meta: { message: 'Sign up success', token: token })
        render :json => {user: serialized_user(resource), meta: { message: 'Sign up success', token: token, otp: otp1.pin }}, :status => :created
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
    
