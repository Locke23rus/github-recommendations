source 'https://rubygems.org'

gem 'rails', '3.2.8'

gem 'mysql2'

#Auth
gem "omniauth", "~> 1.1.1"
gem "omniauth-github", "~> 1.0.3"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'

  gem "twitter-bootstrap-rails", "~> 2.1.3"
end

gem 'jquery-rails'

# Deploy with Capistrano
gem 'capistrano'

gem 'octokit', '~> 1.17.1'
gem "airbrake"

group :test, :development do
  gem "rspec-rails", "~> 2.11.0"
end

group :production do
  gem 'therubyracer'
end

gem "sidekiq", "~> 2.3.3"
gem 'sinatra', require: false
gem 'slim'
