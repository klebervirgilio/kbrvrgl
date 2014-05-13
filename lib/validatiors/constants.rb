module Validators
  # Source: https://github.com/henrik/validates_url_format_of
  IPv4_PART = /\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]/  # 0-255

  URL_FORMAT = %r[
    \A
    https?://                                                    # http:// or https://
    ([^\s:@]+:[^\s:@]*@)?                                        # optional username:pw@
    ( (([^\W_]+\.)*xn--)?[^\W_]+([-.][^\W_]+)*\.[a-z]{2,6}\.? |  # domain (including Punycode/IDN)...
        #{IPv4_PART}(\.#{IPv4_PART}){3} )                        # or IPv4
    (:\d{1,5})?                                                  # optional port
    ([/?]\S*)?                                                   # optional /whatever or ?whatever
    \z
  ]ixs
end