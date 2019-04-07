require 'net/http'
require 'open-uri'
require 'openssl'
require 'json'

module BnmAPI::HTTP
  class Client
    attr_accessor :endpoint

    BASE_API = 'https://api.bnm.gov.my/public'
    HEADER_ACCEPT = 'application/vnd.BNM.API.v1+json'

    def initialize(endpoint:)
      self.endpoint = endpoint
    end

    def request
      uri = prepare_uri
      http = prepare_http(uri)
      http.request(prepare_request(uri))
    end

    def prepare_uri
      uri = BASE_API + endpoint
      URI.parse(uri)
    end

    def prepare_http(uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      http
    end

    def prepare_request(uri)
      req = Net::HTTP::Get.new(uri.request_uri)
      req['Accept'] = HEADER_ACCEPT

      req
    end

  end
end
