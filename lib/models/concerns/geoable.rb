module Geoable
   extend ActiveSupport::Concern

  included do
    def self.create_with_geoip attrs
      country = GeoIpService.new.get_country_from attrs[:ip]
      attrs.merge! country: country
      create(attrs)
    end
  end
end
