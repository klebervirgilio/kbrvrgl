require 'spec_helper'

describe "api" do
  def app
    @app ||= Api
  end

  describe "POST /short" do
    it "should add a new url" do
      Storage::RedisProxy.any_instance
                         .should_receive(:set)
                         .with("www.example.com")
                         .and_return("ID")

      post '/short', :url => "www.example.com"
      expect(last_response.body).to match(/kbrvrgl.me\/ID/)
      expect(last_response.status).to be_eql(201)
    end
  end

  describe "GET /:id" do
    it "should add a new store" do
      Storage::RedisProxy.any_instance
                         .should_receive(:get)
                         .with("ID")
                         .and_return("www.example.com")

      get '/ID'
      expect(last_response.body).to match(/example\.com/)
    end
  end
end