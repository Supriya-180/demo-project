class OtpMailer < ApplicationMailer
	def varify_otp otp,message
	    @otp = otp
	    @message = message
	    mail(to: @otp.email, subject: 'please varify your account through this  otp.')
	  end
end
