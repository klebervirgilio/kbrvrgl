# coding: utf-8
class Api < Sinatra::Base
  use Rack::Auth::Basic, "API" do |username, password|
    username == ENV['SHORTENER_USERNAME']  && password == ENV['SHORTENER_SECRET']
  end

  store = Storage::RedisProxy.new

  not_found { json :message => 'Lost...' }
  error { json :message => 'BOOMM...' }

  post "/short" do
    begin
      id = store.set(params[:url])
      status 201
      json :message => "URL has been added successfully", url: "http://#{DOMAIN}/#{id}"
    rescue Storage::StorageError
      status 422
      json :message => "URL hasnt been added successfully", :reason => e.message
    end
  end

  get "/:id" do
    url = store.get params[:id]
    if url && !url.empty?
      json :message => "", :url => url
    else
      status 404
      json :message => "not found"
    end
  end
end