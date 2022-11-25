class EmailOtp < ApplicationRecord
	before_create :create_ran_otp
	def create_ran_otp
		self.pin=rand(999...10000)   
	end

after_create :vari_otp_email

  def vari_otp_email
    otp = self
    message = "Your OTP for registration is #{otp.pin}"
    OtpMailer.varify_otp(otp,message).deliver_now
  end


end
