shared_context "when app sucessfully redirects" do
  let(:url_hash) { "ID" }
  let(:url) { "http://www.example.com" }

  before do
    Storage::RedisProxy.any_instance
                       .should_receive(:get)
                       .at_least(1)
                       .with(url_hash)
                       .and_return(url)
  end
end


shared_context "when app fails to redirect" do
  before {
    Storage::RedisProxy.any_instance
                       .should_receive(:get)
                       .with("ID")
                       .and_return(nil)
  }
end
