require 'spec_helper'

describe "Create stats for each visualization" do
  def app
    @app ||= App
  end

  context "when fails to redirect" do
    include_context "when app fails to redirect"

    it "should not create a stat" do
      expect{ get('/ID') }.to_not change{Stat.count}.from(0).to(1)
    end
  end

  context "when successfully redirected" do
    include_context "when app sucessfully redirects"

    it "should create a stat" do
      expect{ get(url_hash) }.to change{ Stat.count }.from(0).to(1)
    end
  end
end
