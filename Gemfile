source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "propshaft"
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

gem "kamal", "~> 2.5.2"
gem 'dotenv-rails'
gem "whenever"

#db
gem 'pghero'
gem "pg", "~> 1.1"
gem "pg_search"
gem "strong_migrations"
gem "pg_query"
gem "scenic"

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

group :development, :test do
  gem "byebug"
  gem "brakeman", require: false
  gem 'active_record_doctor'
  gem 'rails-pg-extras'
  gem 'database_consistency'
  gem 'bullet'

  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "rspec-rails", "~> 8.0.0"
  gem "rails-controller-testing"
  gem "database_cleaner"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "shoulda-matchers", "~> 5.0"
  gem "simplecov", "0.17.1", require: false

end
