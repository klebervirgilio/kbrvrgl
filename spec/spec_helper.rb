require 'rack/test'
require 'bundler/setup'

ENV['RACK_ENV'] = 'test'
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

require_relative '../lib/storage'
require_relative '../lib/storage/redis_proxy'
require_relative '../lib/app'
require_relative '../lib/api'

module RSpecMixin
  include Rack::Test::Methods
end

# For RSpec 2.x
RSpec.configure { |c| c.include RSpecMixin }