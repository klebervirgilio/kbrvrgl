class GeoIpService
  def get_country_from ip
    GEOIP.country(ip).country_name
  end
end