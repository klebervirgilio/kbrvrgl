class Stat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :ip
  field :shorten_id
  field :country
  field :referer

  class << self
    def build attrs
      country = GeoIpService.new.get_country_from attrs[:ip]
      attrs.merge! country: country
      create(attrs)
    end
  end
end