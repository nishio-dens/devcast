source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'mysql2'
gem 'convergence'
gem 'turbolinks'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'kaminari'
gem 'settingslogic'
gem 'devise'
gem 'ransack'
gem 'oga'
gem 'rest-client'
gem 'active_hash'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'webpacker', '~> 3.0'
gem 'friendly_id'
gem 'counter_culture', '~> 1.8'
gem 'redcarpet'
gem 'rouge'
gem 'sitemap_generator'
gem 'newrelic_rpm'
gem 'openssl'

group :development, :test do
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'annotate'
  gem 'rubocop'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
  gem 'capistrano-bundler', require: false
end
