require 'spec_helper'

describe GeoIpService do
  it "GEOIP" do
    expect(GEOIP).to be_an_kind_of GeoIP
  end

  it ".get_country_from" do
    GeoIpService.any_instance
         .should_receive(:get_country_from)
         .with('ip...')
         .and_return("Singapore")

    expect(subject.get_country_from("ip...")).to be_eql("Singapore")
  end
end