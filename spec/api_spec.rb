require 'spec_helper'

describe "api" do
  def app
    @app ||= Api
  end

  describe "POST /short" do
    context "Valid URLs" do
      it "should add a new url" do
        Storage::RedisProxy.any_instance
                           .should_receive(:set)
                           .with("http://www.example.com")
                           .and_return("ID")

        post '/short', :url => "http://www.example.com"
        expect(last_response.body).to match(/kbrvrgl.me\/ID/)
        expect(last_response.status).to be_eql(201)
      end
    end

    context "Invalid URLs" do
      it "should not add a new url" do
        Storage::RedisProxy.any_instance
                           .should_not_receive(:set)
                           .with("+++example.com")

        post '/short', :url => "+++example.com"
        expect(last_response.body).to_not match(/kbrvrgl.me\/ID/)
        expect(last_response.status).to be_eql(422)
      end
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