source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'foreigner'
gem 'authlogic', :git => 'git://github.com/binarylogic/authlogic.git'
gem 'nifty-generators'
#gem 'delayed_job','2.1.0.pre2'
gem 'resque' ,:git => 'http://github.com/defunkt/resque.git', :require => 'resque/server'
gem 'resque-forker'
gem 'resque-retry'
gem 'will_paginate', '~> 3.0.beta'

group :assets do
  gem 'sass-rails', "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

gem 'ruby-debug19', :group => :development

group :development, :test do
  gem 'rails-erd'
  gem 'railroady'
  gem 'rspec-rails'
  gem "shoulda-matchers"
  gem 'guard'
  gem 'rb-inotify'
  gem 'libnotify'
  gem "factory_girl_rails", ">= 1.2.0"
  gem 'spork', '~> 0.9.0.rc'
  gem 'annotate', '2.4.1.beta1',:git => 'git://github.com/ctran/annotate_models.git'
end

group :test do
  gem 'capybara'
  gem 'launchy'
end


# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
