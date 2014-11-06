module Validators
  # Source: https://github.com/henrik/validates_url_format_of
  IPv4_PART = /\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]/  # 0-255

  URL_FORMAT = URI.regexp
end
