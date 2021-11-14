require 'bundler'
Bundler.require(:default, :development)

Dotenv.load
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

require_all 'app'
