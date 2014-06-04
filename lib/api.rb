# coding: utf-8
require_relative './storage'
class Api < Sinatra::Base

  if ENV['RACK_ENV'] == "production"
    use Rack::Auth::Basic, "API" do |username, password|
      username == ENV['SHORTENER_USERNAME']  && password == ENV['SHORTENER_SECRET']
    end
  end

  store = Storage::RedisProxy.new

  not_found { json :message => 'Lost...' }

  error { json :message => 'BOOMM...' }

  before "/short" do
    validator = UrlValidator.new(params[:url])
    halt 422, json({:message => 'Invalid URL'}) if !validator.valid?
  end

  before do
   content_type :json
   headers 'Access-Control-Allow-Origin'  => '*',
           'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST']
  end

  after "/short" do
    return if response.status == 422
    UrlMetadata.create_with_geoip(
                  url: params[:url],
                  notes: params[:notes],
                  label: params[:label],
                  shorten_id: @id,
                  ip: request.ip
                )
  end

  post "/short" do
    begin
      @id = store.set(URI.encode(params[:url]))
      status 201
      json :message => "URL has been added successfully", url: "http://#{DOMAIN}/#{@id}"
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
