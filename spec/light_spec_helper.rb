ENV['RACK_ENV'] = 'test'
require 'bundler/setup'
require "pry"
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)
