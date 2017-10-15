require 'giftrocket'

GIFTROCKET_EMBED_PUBLIC_KEY = ENV["GIFTROCKET_EMBED_PUBLIC_KEY"]

# Configure with your sandbox / production token.
Giftrocket.configure do |config|
  config[:access_token] = ENV["GIFTROCKET_API_PRIVATE_KEY"]
  config[:base_api_uri] = ENV["GIFTROCKET_REST_API_HOST"] || "https://testflight.giftrocket.com/api/v1/"
end
