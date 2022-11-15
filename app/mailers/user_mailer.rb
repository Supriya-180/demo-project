class UserMailer < ApplicationMailer
	default from: 'supriyas@witmates.com'

	  def welcome_email user
	  	# byebug
	    @user = user
	    @url  = 'http://localhost:3000/api/v1/users'
	    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
	  end
end



