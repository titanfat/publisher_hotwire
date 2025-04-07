source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bcrypt", "~> 3.1.7"

# support gem/lib
gem "pagy", "~> 9.3"
gem "dry-initializer", "~> 3.0"

# js/css packages
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tailwindcss-rails", " ~> 3.3.1"
gem "view_component"
gem 'requestjs-rails'

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_cable"

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

group :development, :test do
  gem "byebug"
  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "rspec-rails", "~> 7.1.1"
  gem "rails-controller-testing"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", "0.17.1", require: false

end
