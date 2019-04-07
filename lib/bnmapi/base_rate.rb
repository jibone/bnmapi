module BnmAPI
  class BaseRate
    ENDPOINT = '/base-rate'

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

    def self.by_bank_code(bank_code)
      http = BnmAPI::HTTP::Client.new(endpoint: ENDPOINT + '/' + bank_code)

      res = JSON.parse(http.request.read_body)

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
