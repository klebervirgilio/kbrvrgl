ENV["RACK_ENV"] ||= "development"

require "pry" if ENV["RACK_ENV"] != "production"
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

DOMAIN = ENV["SHORTENER_DOMAIN"] || "r.kbrvrgl.me"
GEOIP  = GeoIP.new(File.expand_path("../../bin/GeoIP.dat", __FILE__))
REDIS  = if ENV["RACK_ENV"] != "production"
          Redis.new
        else
          Redis.new(url: ENV['REDISTOGO_URL'])
        end

Dir["./lib/**/*.rb"].each{|f| require f }

Mongoid.load!(File.expand_path("../../config/mongoid.yml", __FILE__))

I18n.enforce_available_locales = false