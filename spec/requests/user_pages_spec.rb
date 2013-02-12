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
end


