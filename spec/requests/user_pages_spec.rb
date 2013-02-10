require 'spec_helper'
#let(:base_title){"Sample App"}

describe "UserPages" do	  
	subject{ page }
	describe "Sign up page" do
	  	before { visit signup_path }
	    it { should have_selector('h1', text: 'Sign up') }
	   # it { should have_selector('title', text: full_title('Sign up')) } ##FAILS Reason Unknown
	   	it { should have_selector('title', text: 'Sample App | Sign up')}
	end
end


