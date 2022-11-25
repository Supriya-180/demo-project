module Api
  module V1
        class AddressesController < ApiController
      before_action :authenticate_user!
      # before_action :account_activated!
           def create
            @address = current_user.addresses.new(address_params)
            if @address.save
              render json: @address
            else
              render json: {meta: {message: 'fxgftyjk'}}
            end
           end

            private
            
            def address_params
              params.require(:address).permit(:user_id, :pin_code, :flat_no, :colony, :landmark, :city)
            end
        end
  end
end