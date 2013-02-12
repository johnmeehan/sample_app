#factories.rb

#a factory to simulate User model objects
FactoryGirl.define do
	factory :user do
		name "Test"
		email "test@example.com"
		password "foobar"
		password_confirmation "foobar"
	end

end