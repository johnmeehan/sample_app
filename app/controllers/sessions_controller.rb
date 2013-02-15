class SessionsController < ApplicationController

	def new

	end

	def create
		user = User.find_by_email(params[:session][:email])
		if user && user.authenticate(params[:session][:password])
			#sign the user in and redirect to the user's show page
			#8.2
			sign_in user
			redirect_to user
 		else
			#flash.now to fix flash persistance error
			flash.now[:error] = 'Invalid email/password combination'
			render 'new'
		end
	end

	def destroy

	end
end
