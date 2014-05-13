ENV["RACK_ENV"] ||= "development"

require "pry" if ENV["RACK_ENV"] != "production"
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

DOMAIN = ENV["SHORTENER_DOMAIN"] || "r.kbrvrgl.me"
REDIS  = if ENV["RACK_ENV"] != "production"
          Redis.new
        else
          Redis.new(url: ENV['REDISTOGO_URL'])
        end

Dir["./lib/**/*.rb"].each{|f| require f }