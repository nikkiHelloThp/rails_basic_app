source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

gem 'rails', '~> 5.2.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bcrypt', '~> 3.1.7'
gem 'pry', '~> 0.12.2'
gem 'faker', '~> 2.2', '>= 2.2.1'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'will_paginate', '~> 3.1', '>= 3.1.6'
gem 'active_storage_validations', '~> 0.8.8'
gem 'image_processing', '~> 1.10', '>= 1.10.3'

group :development, :test do
  gem 'byebug', '~> 11.1', '>= 11.1.3', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring', '~> 2.1'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver', '~> 3.142', '>= 3.142.7'
  gem 'chromedriver-helper', '~> 2.1', '>= 2.1.1'
  gem 'minitest-reporters', '~> 1.4', '>= 1.4.2'
  gem 'mini_backtrace', '~> 0.1.3'
  gem 'guard', '~> 2.16', '>= 2.16.2'
  gem 'guard-minitest', '~> 2.4', '>= 2.4.6'
  gem 'rails-controller-testing', '~> 1.0', '>= 1.0.4'
end

group :production do
  gem 'aws-sdk-s3', '~> 1.63'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
