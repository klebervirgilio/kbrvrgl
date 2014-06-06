# coding: utf-8
require_relative './storage'
class Api < Sinatra::Base

  configure :production, :development do
    enable :logging
  end

  helpers do
    def protected!
      return if authorized?
      headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
      halt 401, "Not authorized\n"
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? and @auth.basic? and @auth.credentials and @auth.credentials == [ENV['SHORTENER_USERNAME'], ENV['SHORTENER_SECRET']]
    end
  end

  set(:method) do |method|
    method = method.to_s.upcase
    condition { request.request_method == method }
  end

  store = Storage::RedisAdapter.new

  not_found { json :message => 'Lost...' }

  error { json :message => 'BOOMM...' }

  before do
    content_type :json
     headers 'Access-Control-Allow-Origin'  => '*',
             'Access-Control-Allow-Methods' => ['OPTIONS', 'GET', 'POST'],
             'Access-Control-Allow-Headers' => 'Content-Type',
             'Access-Control-Allow-Credentials' => 'true',
             "Access-Control-Allow-Headers" => "Authorization"

     if request.request_method == 'OPTIONS'
       halt 200, 'Preflight!'
     end
  end

  before { protected! if ENV['RACK_ENV'] == 'production' }

  before "/short", :method => :post do
    validator = UrlValidator.new(params[:url])
    halt 422, json({:message => 'Invalid URL'}) if !validator.valid?
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
