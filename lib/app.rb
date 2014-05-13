# coding: utf-8
require_relative './storage'
class App < Sinatra::Base
  store = Storage::RedisProxy.new

  not_found { "URL resquested not found" }
  error { "Something wrong happend" }
  register Sinatra::Twitter::Bootstrap::Assets

  get "/" do
    slim :index
  end

  get "/:id" do
    url = store.get params[:id]
    if url && !url.empty?
      redirect url
    else
      status 404
    end
  end
end