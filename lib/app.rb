# coding: utf-8
require_relative './storage'
class App < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  store = Storage::RedisAdapter.new

  not_found { "URL resquested not found" }

  error { "Something wrong happend" }


  after "/:id" do
    ViewCounter.find_and_increment_or_create params[:id] if response.redirect?
  end

  after "/:id" do
    if response.redirect?
      Stat.create_with_geoip(
        shortner_id: params[:id],
        ip: request.ip,
        referer: request.referer
      )
    end
  end

  get "/" do
    erb :index
  end

  get "/:id" do
    url = store.get params[:id]
    if url && !url.empty?
      redirect URI.encode(url)
    else
      status 404
    end
  end
end
