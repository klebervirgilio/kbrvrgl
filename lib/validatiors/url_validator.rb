class UrlValidator
  attr_reader :url
  def initialize url
    @url = url
  end

  def valid?
    Validators::URL_FORMAT =~ @url
  end
end