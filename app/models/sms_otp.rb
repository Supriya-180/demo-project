class SmsOtp < ApplicationRecord
	before_create :create_ran_otp
	def create_ran_otp
		self.pin=rand(999...10000)   
	end

	# after_create :vari_otp

    #   def vari_otp
    #   	# byebug
    #     otp = self
    #     message = "Your OTP for registration is #{otp.pin}"
    #     # TwilioTextMessenger.new(message, otp.phone_number).call
    #   end
    
end


