# coding: utf-8
require File.expand_path("../config/boot", __FILE__)

run Rack::URLMap.new({
  "/api"  => Api,
  "/"  => App
})
