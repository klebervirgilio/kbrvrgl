class Stat
  include Mongoid::Document
  include Mongoid::Timestamps
  include Geoable

  field :ip
  field :shorten_id
  field :country
  field :referer
end
