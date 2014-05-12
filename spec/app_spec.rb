require 'spec_helper'

describe "app" do
  def app
    @app ||= App
  end

  describe "GET /:id" do
    it "should add a new store" do
      Storage::RedisProxy.any_instance
                         .should_receive(:get)
                         .with("ID")
                         .and_return("www.example.com")

      get '/ID'
      expect(last_response).to be_redirect
    end
  end
end