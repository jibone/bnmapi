# frozen_string_literal: true

module BnmAPI

  # :main: README.rdoc

  ##
  # Retrive the currency exchange rates from the Interbank Foreign Exchange
  # Market in Kuala Lumpur. The price of selected countries currency in relation
  # to Ringgit
  #
  class ExchangeRate

    ##
    # API endpoint:: /base-rate
    # API documentation:: https://api.bnm.gov.my/portal#tag/Exchange-Rates
    ENDPOINT = '/exchange-rate'

    ##
    # Get the list of latest currency exchange rates
    #
    #   fx_rate_collection = BnmAPI::ExchangeRate.latest
    #
    #   puts fx_rate_collection[0].currency_code
    #   puts fx_rate_collection[0].unit
    #   puts fx_rate_collection[0].date
    #   puts fx_rate_collection[0].buying_rate
    #   puts fx_rate_collection[0].selling_rate
    #   puts fx_rate_collection[0].middle_rate
    #   puts fx_rate_collection[0].quote
    #   puts fx_rate_collection[0].last_update
    #   puts fx_rate_collection[0].session
    #
    def self.latest
      http = BnmAPI::HTTP::Client.new(endpoint: ENDPOINT)

      res = JSON.parse(http.request.read_body)

      collection = []

      res['data'].each do |data|
        collection << BnmAPI::Data::ExchangeRate.new(
          data['currency_code'],
          data['unit'],
          data['rate']['buying_rate'],
          data['rate']['selling_rate'],
          data['rate']['middle_rate'],
          data['rate']['date'],
          res['meta']['quote'],
          res['meta']['session'],
          res['meta']['last_updated']
        )
      end

      collection
    end
  end
end
