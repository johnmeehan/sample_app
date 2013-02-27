source 'https://rubygems.org'

gem 'rails', '3.2.9'
gem 'bootstrap-sass' # use twitter bootstrap
gem 'pg'
gem 'bcrypt-ruby', '3.0.1'  # to encrypt passwords etc
gem 'faker', '1.0.1' # makes semi realisic users to test the site
gem 'will_paginate', '3.0.3' #paginate the users page
gem 'bootstrap-will_paginate','0.0.6'# configures will paginate to use Bootstraps pagination styles


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails'
	gem 'guard'     					#autorun test when there is a change
	gem 'guard-rspec'
	gem 'guard-spork', '0.3.2'	
	gem 'annotate', '~> 2.4.1.beta'		# annotate models  
end

group :test do
	gem 'rspec-rails'
	gem 'capybara', '1.1.2'
	gem 'rb-inotify', '0.8.8'
	gem 'libnotify', '0.5.9'

	#ch3.6.3
	gem 'spork', '~>0.9.0'				#sets up an instance so that it removes the startup time for running tests
	# ch7
	gem 'factory_girl_rails', '1.4.0'
end

group :production do
	gem 'pg'							# Database
end
# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
