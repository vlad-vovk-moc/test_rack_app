require 'bundler'
Bundler.require(:default)

require './application.rb'

use Rack::Reloader

run Application.new