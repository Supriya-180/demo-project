class ApplicationController < ActionController::Base

   
    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?

    before_action :authenticate_user!
    

    protected

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :gender, :user_type, :validity, :phone_number])
    		devise_parameter_sanitizer.permit(:account_update, keys: [:name, :gender, :user_type, :validity, :email, :phone_number])
        end


    # def not_found
    #     raise ActionController::RoutingError.new('Not Found')
    # end

end
