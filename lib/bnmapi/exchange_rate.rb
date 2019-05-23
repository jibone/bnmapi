module BnmAPI
  class ExchangeRate
    ENDPOINT = '/exchange-rate'

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
