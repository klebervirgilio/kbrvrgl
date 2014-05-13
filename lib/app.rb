# coding: utf-8
require_relative './storage'
class App < Sinatra::Base
  register Sinatra::Twitter::Bootstrap::Assets

  store = Storage::RedisProxy.new

  not_found { "URL resquested not found" }

  error { "Something wrong happend" }


  after "/:id" do
    ViewCounter.find_and_increment_or_create params[:id] if response.ok?
  end

  after "/:id" do
    Stat.build(
      shortner_id: params[:id],
      ip: request.ip,
      referer: request.referer
    )
  end

  get "/" do
    slim :index
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