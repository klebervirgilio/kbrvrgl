require 'rack/test'
require 'bundler/setup'

ENV['RACK_ENV'] = 'test'
require File.expand_path("../../config/boot.rb", __FILE__)

path = File.expand_path("../..", __FILE__)

require "#{path}/lib/storage"

Dir["#{path}/lib/**/*.rb"].each{|f| require f }

Dir["#{path}/spec/support/**/*.rb"].each{|f| require f }

module RSpecMixin
  include Rack::Test::Methods
end

# For RSpec 2.x
RSpec.configure { |config|
  config.include RSpecMixin

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
}
