class UrlMetadata
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geoable

  field :shorten_id
  field :url
  field :country
  field :notes
  field :label
end
