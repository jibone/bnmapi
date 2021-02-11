# frozen_string_literal: true

module BnmAPI

  # :main: README.rdoc

  ##
  # Retrive the current base rate and base lending rates for retail loans or
  # financing facilities and indicative effective lending rates for a standard
  # housing loan/home financing offered by financial insitutions.
  #
  class BaseRate

    ##
    # API endpoint:: /base-rate
    # API documentation:: https://api.bnm.gov.my/portal#tag/Base-RatesBLREffective-LR
    #
    ENDPOINT = '/base-rate'

    ##
    # Creates a list of bank information with base rate and base lending rates.
    #
    #   collection = BnmAPI::BaseRate.latest
    #
    #   collection.size
    #   # (number of banks that the response return)
    #
    #   puts collection[0].bank_code
    #   puts collection[0].bank_name
    #   puts collection[0].base_rate
    #   puts collection[0].base_financing_rate
    #   puts collection[0].base_lending_rate
    #   puts collection[0].last_updated.class
    #   puts collection[0].last_updated.iso8601
    #   puts collection[0].effective_date.class
    #   puts collection[0].effective_date.iso8601
    #
    def self.latest
      http = BnmAPI::HTTP::Client.new(endpoint: ENDPOINT)

      res = JSON.parse(http.request.read_body)

      collection = []

      res['data'].each do |data|
        collection << BnmAPI::Data::BankBaseRate.new(
          data['bank_code'],
          data['bank_name'],
          data['base_rate'],
          data['base_lending_rate'],
          data['base_financing_rate'],
          data['indicative_eff_lending_rate'],
          res['meta']['last_updated'],
          res['meta']['effective_date']
        )
      end

      collection
    end

    ##
    # Retrive bank infomation with base rate and base lending rates for a single
    # bank based on the bank code
    #
    #   bank = BnmAPI::BaseRate.by_bank_code('BKKBMYKL')
    #
    #   puts bank.bank_code
    #   puts bank.bank_name
    #   puts bank.base_rate
    #   puts bank.base_lending_rate
    #   puts bank.indicative_eff_lending_rate
    #   puts bank.last_updated.class
    #   puts bank.last_updated.iso8601
    #   puts bank.effective_date.class
    #   puts bank.effective_date.iso8601
    #
    def self.by_bank_code(bank_code)
      http = BnmAPI::HTTP::Client.new(endpoint: ENDPOINT + '/' + bank_code)

      response = http.request
      if response.code == '404'
        raise BnmAPI::Error::InvalidBankCode.new(bank_code: bank_code)
      end

      res = JSON.parse(response.read_body)

      BnmAPI::Data::BankBaseRate.new(
          res['data']['bank_code'],
          res['data']['bank_name'],
          res['data']['base_rate'],
          res['data']['base_lending_rate'],
          res['data']['base_financing_rate'],
          res['data']['indicative_eff_lending_rate'],
          res['meta']['last_updated'],
          res['meta']['effective_date']
      )
    end
  end
end
