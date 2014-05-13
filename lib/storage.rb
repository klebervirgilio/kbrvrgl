# coding: utf-8
module Storage
  PREFIX = "kbrvrgl:"
  class StorageError < StandardError; end
end

require './lib/storage/redis_proxy'