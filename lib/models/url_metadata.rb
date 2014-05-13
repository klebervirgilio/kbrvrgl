class UrlMetada
  include Mongoid::Document
  include Mongoid::Timestamps

  field :shorten_id
  field :url
  field :country
  field :notes
  field :label

  class << self
    def build attrs
      country = GeoIpService.new.get_country_from attrs[:ip]
      attrs.merge! country: country
      create(attrs)
    end
  end
end