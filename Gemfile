source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'rails', '~> 6.1.4'
gem 'pg', '~> 1.1'
gem "puma", ">= 5.5.1"
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'
gem 'bootsnap', '>= 1.4.4', require: false
#gem "passenger", ">= 5.0.25", require: "phusion_passenger/rack_handler"

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
end

group :test do
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

gem "haml-rails", "~> 2.0"
gem 'listen', '~> 3.3'
gem 'font-awesome-sass', '~> 5.15.1'
gem 'simple_form'
gem "actionpack", ">= 6.1.4.1"
gem "aws-sdk-s3", require: false #save images and files in production
gem 'active_storage_validations' #validate image and file uploads
gem 'rails-i18n'
gem "image_processing"
gem 'mimemagic', '~> 0.3.10'
gem 'devise'
gem 'devise-i18n'