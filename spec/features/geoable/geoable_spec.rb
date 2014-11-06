require 'light_spec_helper'
require_relative '../../../lib/services/geo_ip_service'
require_relative '../../../lib/models/concerns/geoable'

class Dummy
  include Geoable

  def create *args
  end
end


describe "Geoable" do
  describe '::create_with_geoip' do
    specify { expect(Dummy).to be_respond_to(:create_with_geoip) }

    it "should add country to the params" do
      GeoIpService.any_instance
                  .should_receive(:get_country_from)
                  .with('ip')
                  .and_return('country')

      Dummy.should_receive(:create).with({country: 'country', ip: 'ip'})
      Dummy.create_with_geoip({ip: 'ip'})
    end
  end
end
