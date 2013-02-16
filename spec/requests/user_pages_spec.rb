require 'spec_helper'
#let(:base_title){"Sample App"}

describe "User Pages" do	  
	subject{ page }
	describe "Sign up page" do
	  	before { visit signup_path }
	    it { should have_selector('h1', text: 'Sign up') }
	   # it { should have_selector('title', text: full_title('Sign up')) } ##FAILS Reason Unknown
	   	it { should have_selector('title', text: 'Sample App | Sign up')}
	end

	#i had an error here as i was ending the "user pages" block early so this test had not "page" context
	describe "Profile page" do 
		let(:user){ FactoryGirl.create(:user) } #ch7.1
		before { visit user_path(user) }
		it { should have_selector('h1', text: user.name)}
		it { should have_selector('title', text: full_title(user.name))} # added in full title() as it is the format that is displayed in the header
	end


	describe "signup" do
		before{ visit signup_path }
		let(:submit){"Create my account"}

		describe "with invalid information" do
			it "should not create a user" do
				expect { click_button submit}.not_to change(User, :count)
			end
		end
		describe "with valid information" do
			before do
				fill_in "Name", with: "Example User"
				fill_in "Email", with: "user@example.com"
				fill_in "Password", with: "foobar"
				fill_in	"Confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit}.to change(User, :count).by(1)
			end
			describe "after saving the user" do
				it {should have_link('Sign out')}
			end
		end

	end
end


