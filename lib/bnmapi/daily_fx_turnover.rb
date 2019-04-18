module BnmAPI
  class DailyFXTurnover
    ENDPOINT = '/fx-turn-over'

    def self.latest
      res = fetch_data(ENDPOINT)
      present_data(res['data'], res['meta']['last_updated'])
    end

    def self.by_date(date)
      date_string = if date.is_a?(Date)
        "#{date.year}-#{date.month}-#{date.day}"
      else
        d = Date.parse(date)
        "#{d.year}-#{d.month}-#{d.day}"
      end

      res = fetch_data(ENDPOINT + '/date/' + date_string)
      present_data(res['data'], res['meta']['last_updated'])
    end

    def self.by_month(year:, month:)
      res = fetch_data("#{ENDPOINT}/year/#{year}/month/#{month}")

      collection = []
      res['data'].each do |data|
        collection << present_data(data, res['meta']['last_updated'])
      end

      collection
    end

    private

    def self.fetch_data(endpoint)
      http = BnmAPI::HTTP::Client.new(endpoint: endpoint)
      res = http.request

      if res.code == '404'
        raise BnmAPI::Error::NoFXTurnover.new(endpoint: endpoint)
      end

      JSON.parse(res.read_body)
    end

    def self.present_data(data, last_updated)
      BnmAPI::Data::FXTurnover.new(
        data['total_sum'],
        data['date'],
        last_updated
      )
    end
  end
end
