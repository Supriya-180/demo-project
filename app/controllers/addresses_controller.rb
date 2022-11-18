class AddressesController < ApplicationController
   def new
   	@address = current_user.addresses.new
   end

   def create
   	@address = current_user.addresses.new(address_params)
    # byebug
   	if @address.save
   		redirect_to home_index_path
   	else
   		render 'new'
   	end
   end

    private
    
    def address_params
      params.require(:address).permit(:user_id, :pin_code, :flat_no, :colony, :landmark, :city)
    end
end
