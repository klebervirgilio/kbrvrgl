ENV["RACK_ENV"] ||= "development"

require "pry" if ENV["RACK_ENV"] != "production"
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require './lib/storage'
require './lib/storage/redis_proxy'
require './lib/app'
require './lib/api'