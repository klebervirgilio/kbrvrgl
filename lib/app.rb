# coding: utf-8

# TODO
# Validatior Midlleware: URL
# Service, background, to find more information about the IP
# More data will be stored, refer, ip, views(incr)
# /:id/stats - simple view where will be possible see the details about the url.

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