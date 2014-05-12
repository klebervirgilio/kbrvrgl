# coding: utf-8
class App < Sinatra::Base
  store = Storage::RedisProxy.new

  not_found { "URL resquested not found" }
  error { "Something wrong happend" }

  get "/:id" do
    url = store.get params[:id]
    if url && !url.empty?
      redirect url
    else
      status 404
    end
  end
end