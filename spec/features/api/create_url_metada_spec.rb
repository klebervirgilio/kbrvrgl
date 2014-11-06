require 'spec_helper'

describe "Create url metadata for each shorten url" do
  def app
    @app ||= Api
  end

  context "for invalids urls" do
    it "does not create an url metadata" do
      expect{
        post '/short', :url => "++example.com"
      }.to_not change{ UrlMetadata.count }
    end
  end

  context "for valids urls" do
    before {
      Storage::RedisAdapter.any_instance
                 .should_receive(:set)
                 .at_least(1)
                 .with("http://www.example.com", nil)
                 .and_return("ID")
    }

    it "creates an url metadata" do
      expect{
        2.times{ post '/short', :url => "http://www.example.com" }
      }.to change{ UrlMetadata.count }.from(0).to(2)
    end
  end
end
