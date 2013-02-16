class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])

	end
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			sign_in @user # signs in the the user after signing up
			flash[:success] = "Welcome to the Sample App!"
			#Handle a successful save
			redirect_to @user 
		else
			render 'new'
		end
	end
end
