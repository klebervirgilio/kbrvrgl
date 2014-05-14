require 'spec_helper'

describe "app" do
  def app
    @app ||= App
  end

  describe "GET /:id" do
    context "when id exsits" do
      include_context "when app sucessfully redirects"
      it "should redirects for the stored url" do
        get '/ID'
        expect(last_response).to be_redirect
      end
    end

    context "when id does not exsits" do
      include_context "when app fails to redirect"

      subject! { get('/ID') }

      describe "status" do
        it { should be_not_found }
      end
    end
  end
end
