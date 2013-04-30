class UsersController < ApplicationController
	#before filter arranges for a particular method to be called before the given actions.
	before_filter :signed_in_user, only: [:index,:edit,:update, :following, :followers]
	before_filter :correct_user, only:[:edit,:update]
	before_filter :admin_user, only: :destroy

	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.followed_users.paginate(page: params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(page: params[:page])
		render 'show_follow'
	end

	def index
		#@users = User.all #not the best way of doing this as i dont need "all" of them
		@users = User.paginate(:page => params[:page])
	end

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(page: params[:page])
	end
	
	def new
		if self.signed_in?
			redirect_to root_path
		else
			@user = User.new
		end
	end

	def create
		if self.signed_in?
			redirect_to root_path
		else
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

	def edit
		#@user = User.find(params[:id])
	end

	def update
		#@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			#Handle a successful update
			flash[:success] = "Profile updated"
			sign_in @user #sign user back in as remember token gets reset when user is saved
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		#Modify the destroy action to prevent admin users from destroying themselves.
		if current_user == User.find(params[:id])
			
			flash[:warning] = "Action not allowed"
		else
			User.find(params[:id]).destroy
			flash[:success] = "User destroyed."
		end
		redirect_to users_path
	end

	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)	
		end

		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end
end
