require 'spec_helper'

describe "Static Pages" do

	#ch3.30 clean up test 
	let(:base_title){"Sample App"}


  describe "Home page" do
    it "it should have the h1 'Sample App'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit root_path
      page.should have_selector('h1', :text => 'Sample App')
    end
   it "should have the base title" do
   		visit root_path
   		page.should have_selector('title', :text => "Sample App")
   end
   it "should not have a custom page title" do
   	visit root_path
   	page.should_not have_selector('title',:text => '| Home')
   end
  end

   describe "Help page" do
    it "it should have the h1 'Help'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit help_path
      page.should have_selector('h1', :text => 'Help')
   	end

   	it "should have the title 'Help'" do
   		visit help_path
   		page.should have_selector('title', :text => "#{base_title} | Help")
   	end
   end

  describe "About page" do
  	it "should have the h1 'About Us'" do
  		visit about_path
  		page.should have_selector('h1', :text => 'About Us')

  	end
  	it "should have the title 'About Us'" do
  		visit about_path
  		page.should have_selector('title', :text => "#{base_title} | About Us")
  	end
  end

   describe "Contact Page" do
    it "it should have the h1 'Contact'" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit contact_path
      page.should have_selector('h1', :text => 'Contact')
   	end
   	

   	it "should have the title 'Contact'" do
   		visit contact_path
   		page.should have_selector('title', :text => "#{base_title} | Contact")
   	end
   end
end
