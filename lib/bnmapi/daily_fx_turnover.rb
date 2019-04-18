module BnmAPI
  class DailyFXTurnover
    ENDPOINT = '/fx-turn-over'

    def self.latest
      http = BnmAPI::HTTP::Client.new(endpoint: ENDPOINT)

      res = JSON.parse(http.request.read_body)

      BnmAPI::Data::FXTurnover.new(
        res['data']['total_sum'],
        res['data']['date'],
        res['meta']['last_updated']
      )
    end

    def self.by_date(date)
      date_string = if date.is_a?(Date)
        "#{date.year}-#{date.month}-#{date.day}"
      else
        d = Date.parse(date)
        "#{d.year}-#{d.month}-#{d.day}"
      end

      endpoint = ENDPOINT + '/date/' + date_string
      http = BnmAPI::HTTP::Client.new(endpoint: endpoint)

      res = JSON.parse(http.request.read_body)

      BnmAPI::Data::FXTurnover.new(
        res['data']['total_sum'],
        res['data']['date'],
        res['meta']['last_updated']
      )
    end

    def self.by_month(year:, month:)
      endpoint = "#{ENDPOINT}/year/#{year}/month/#{month}"

      http = BnmAPI::HTTP::Client.new(endpoint: endpoint)

      res = JSON.parse(http.request.read_body)

      collection = []
      res['data'].each do |data|
        collection << BnmAPI::Data::FXTurnover.new(
          data['total_sum'],
          data['date'],
          res['meta']['last_updated']
        )
      end

      collection
    end
  end
end
