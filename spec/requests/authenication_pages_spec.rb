require 'spec_helper'

describe "AuthenicationPages" do
	subject { page }

	describe "Signin page" do
	  	before{ visit signin_path }
	    it { should have_selector('h1', text: 'Sign in') } 
	    it { should have_selector('title', text: 'Sign in') }


		describe "with invalid information" do
		  	before{ click_button "Sign in" }
		  	it { should have_selector('title', text: 'Sign in') }
		    it { should have_selector('div.alert.alert-error', text: 'Invalid') } 


		    #catch flash persistance bug
		    describe "after visiting another page" do
		    	before{ click_link "Home"}
		    	it {should_not have_selector('div.alert.alert-error')}
		    end
		end

	    describe "with valid informataion" do
	    	let(:user){FactoryGirl.create(:user)}
	    	#before do	
	    	#	fill_in "Email", with: user.email
	    	#	fill_in "Password", with: user.password
	    	#	click_button "Sign in"
	    	#end
	    	before { sign_in user }
	    	it { should have_selector('title', text: user.name)}
	    	it { should have_link('Users', href: users_path)} #list of all users 	    	
	    	it { should have_link('Profile', href: user_path(user))}
	    	it { should have_link('Settings', href: edit_user_path(user))}
	    	it { should have_link('Sign out', href: signout_path)}
	    	it { should_not have_link('Sign in', href: signin_path)}

	    	describe "followed by sign out" do
	    		before { click_link "Sign out" }
	    		it { should have_link('Sign in') }
	    	end
		end
	end

	describe "autherization" do 
		# testing that the edit and update actions are protected 
		describe "for non-signed-in user" do 
			let(:user){FactoryGirl.create(:user)}

			describe "in the Users controller" do
				
				describe "visiting the edit page" do
					before{ visit edit_user_path(user) }
					it { should have_selector('title', text: 'Sign in')}
				end

				describe "submitting to the update action" do
					before { put user_path(user) }
					specify { response.should redirect_to(signin_path)}
				end

				#Test that the index action is protected
				describe "visiting the user index" do
					# not sigined in i should end up at the sign in page if not signed in
					before { visit users_path }
					it { should have_selector('title', text: "Sign in") } 
				end
			end

			#Test for friendly forwarding. after valid signin resulting page should be Edit user page
			describe "when attempting to visit a protected page" do
				before do
					visit edit_user_path(user)
					fill_in "Email",  with: user.email
					fill_in "Password", with: user.password
					click_button "Sign in"
				end

				describe "after sign in" do
					it "should render the desired protected page" do
						page.should have_selector('title', text: 'Edit user')
					end
				end

			end
		end

		#Testing that the edit and update actions require the right user
		describe "as the wrong user" do 
			let(:user) { FactoryGirl.create(:user)}
			let(:wrong_user){ FactoryGirl.create(:user, email: "wrong@example.com")}
			before { sign_in user }

			describe "visiting Users#edit page" do
				#try visit somebody elses edit path
				before{ visit edit_user_path(wrong_user)}
				#i should not be on the edit page
				it { should_not have_selector('title', text: full_title('Edit user'))}
			end	

			describe "submitting a PUT request to the Users#update action" do
				#try update sombody elses profile
				before{ put user_path(wrong_user) }
				specify { response.should redirect_to(root_path) }
			end
		end
	end
end