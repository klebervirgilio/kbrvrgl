require 'spec_helper'

describe "Create or Increment a view counter for each url view" do
  def app
    @app ||= App
  end

  context "when fails to redirect" do
    include_context "when app fails to redirect"

    it "should not create a view counter" do
      expect{ get('/ID') }.to_not change{ViewCounter.count}.from(0).to(1)
    end
  end

  context "when successfully redirected" do
    include_context "when app sucessfully redirects"

    it "should create a view counter" do
      expect{ get(url_hash) }.to change{ViewCounter.count}.from(0).to(1)
    end

    it "should incremnet the view counter" do
      get(url_hash)
      view = ViewCounter.last
      expect{
        2.times{ get(url_hash) }
      }.to change{view.reload.views}.from(1).to(3)
    end
  end
end
