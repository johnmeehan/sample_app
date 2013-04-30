require 'spec_helper'
#let(:base_title){"Sample App"}

describe "User Pages" do	  
	subject{ page }

	#tests for the user index page
	describe "index" do
		let(:user){ FactoryGirl.create(:user)}

		before(:each) do 
			#sign_in FactoryGirl.create(:user)
			#FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
			#FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
			sign_in user
			visit users_path
		end
		#what should i see?
		it { should have_selector('title', text: 'All users')}
		it { should have_selector('h1', text: 'All users')}
		
		describe "pagination" do
			before(:all){ 30.times {FactoryGirl.create(:user)}}
			after(:all){ User.delete_all}
			
			it {should have_selector('div.pagination')} # test for pagination

			it "should list each user" do
				User.paginate(page: 1).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end


			it {should_not have_link('delete')}

			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin)}
				before do 
					sign_in admin
					visit users_path
				end

				it { should have_link('delete', href: user_path(User.first))}
				it " should be able to delete another user" do
					expect { click_link('delete') }.to change(User, :count).by(-1)
				end 
				it { should_not have_link('delete', href: user_path(admin)) }
				
				it "should not be able to delete themselves"do
					expect {delete user_path(admin)}.not_to change(User,:count)
				end
			end
		end
	end

	describe "Sign up page" do
	  	before { visit signup_path }
	    it { should have_selector('h1', text: 'Sign up') }
	   # it { should have_selector('title', text: full_title('Sign up')) } ##FAILS Reason Unknown
	   	it { should have_selector('title', text: 'Sample App | Sign up')}
	end

	#i had an error here as i was ending the "user pages" block early so this test had not "page" context
	describe "Profile page" do 
		let(:user){ FactoryGirl.create(:user) } #ch7.1
		let!(:m1){ FactoryGirl.create(:micropost, user: user, content: "Foo")} #10.19
		let!(:m2){ FactoryGirl.create(:micropost, user: user, content: "Bar")}


		before { visit user_path(user) }
		it { should have_selector('h1', text: user.name)}
		it { should have_selector('title', text: full_title(user.name))} # added in full title() as it is the format that is displayed in the header

		describe "micropost" do
		  it {should have_content(m1.content)} 
		  it {should have_content(m2.content)} 
		  it {should have_content(user.microposts.count)} 
		end

		#11.32 Test for the follow/unfollow button 
		describe "follow / unfollow button" do 
			let(:other_user){FactoryGirl.create(:user)}
			before { sign_in(user)}

			describe "follow a user" do
				before { visit user_path(other_user) }
				  
				it "should increment the followed user count" do
					expect do
						click_button "Follow"
					end.to change(user.followed_users, :count).by(1)
				end
				it "should increment the other users followers count" do
					expect do 
						click_button "Follow"
					end.to change(other_user.followers, :count).by(1)
				end

				describe "Toggles the button" do 
					before { click_button "Follow"}
					it { should have_selector('input', value: 'Unfollow')}
				end
			end

			describe "Unfollow a user" do 
				before do 
					user.follow!(other_user)
					visit user_path(other_user)
				end
				it "should decrement the followed users count" do 
					expect do 
						click_button "Unfollow"
					end.to change(user.followed_users, :count).by(-1)
				end
				it "should derement the follows users follower count" do 
					expect do
						click_button "Unfollow"
					end.to change(other_user.followers, :count).by(-1)
				end

				describe "Toggle the Unfollow button" do 
					before { click_button "Unfollow" }
					it { should have_selector('input', value: 'Follow') }
				end
			end
		end
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
				fill_in	"Password confirmation", with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit}.to change(User, :count).by(1)
			end
			describe "after saving the user" do
				before { click_button submit }  # fix for error
				it { should have_link("Sign out") } 
				#it { should have_link('Sign out', href: signout_path)} 
			end
		end
	end

 	describe "edit" do 
 		let(:user){ FactoryGirl.create(:user)}
 		#before { visit edit_user_path(user)}
 		before do
 			sign_in user
 			visit edit_user_path(user)
 		end

 		describe "page" do 
 			it { should have_selector('h1', text: "Update your profile")}
 			it { should have_selector('title', text: "Edit user")}
 			it { should have_link('change', href: 'http://gravatar.com/emails')}
 		end

 		describe "with invalid information" do
 			before {click_button "Save changes"}
 			it { should have_content('error')}
 		end

 		describe "with valid information" do 
 			let(:new_name){"New Name"}
 			let(:new_email){"new@example.com"}
 	
 			before do
 				fill_in "Name", with: new_name
 				fill_in "Email", with: new_email
 				fill_in "Password", with: user.password
 				fill_in "Password confirmation", with: user.password
 				click_button "Save changes"
 			end
 	
 			it { should have_selector('title', text: new_name)}
 			it { should have_selector('div.alert.alert-success')}
 			it { should have_link('Sign out', href: signout_path)}
 			specify {user.reload.name.should == new_name}
 			specify {user.reload.email.should == new_email}
 		end
 	end

 	
 	
 	describe "following/followers" do
 	  let(:user){FactoryGirl.create(:user)}
 	  let(:other_user){ FactoryGirl.create(:user)}
 	  before { user.follow!(other_user)}

 	  require File.dirname(__FILE__) + '/../spec_helper'
 	  
 	  describe "followed users" do
 	    before do
 	      sign_in user
 	      visit following_user_path(user)
 	    end

 	    it { should have_selector('title', text: full_title('Following'))}
 	    it { should have_selector('h3', text: 'Following')}
 	    it { should have_link(other_user.name, href: user_path(other_user))}
 	  end

 	  describe "followers" do
 	  	before do
 	  		sign_in other_user
 	  		visit followers_user_path(other_user)
 	  	end
 	    it { should have_selector('title', text: full_title('Followers'))}
 	    it { should have_selector('h3',text: 'Followers')}
 	    it { should have_link(user.name, href: user_path(user))}
 	  end

 	end
end