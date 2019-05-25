# frozen_string_literal: true

module BnmAPI
  ##
  # Daily foreign exchange turnover for all currencies including interbank and
  # customer deals.
  #
  class DailyFXTurnover
    ##
    # API endpoint:: /fx-turn-over
    # API documentation:: https://api.bnm.gov.my/portal#tag/Daily-FX-Turnover
    ENDPOINT = '/fx-turn-over'

    ##
    # Get the latest FX turnover
    #
    #   fx_turn_over = BnmAPI::DailyFXTurnover.latest
    #
    #   puts fx_turn_over.date.iso8601
    #   puts fx_turn_over.total_sum
    #   puts fx_turn_over.last_updated
    #
    def self.latest
      res = fetch_data(ENDPOINT)
      present_data(res['data'], res['meta']['last_updated'])
    end

    ##
    # Get daily FX turnover by date.
    #
    # From an initialize Date object
    #   date = Date.parse('10-4-2019')
    #   fx_turn_over = BnmAPI::DailyFXTurnover.by_date(date)
    #
    # From a string that can be parse to a date
    #   fx_turn_over = BnmAPI::DailyFXTurnover.by_date('10-4-2019')
    #
    # Usage
    #   puts fx_turn_over.date.iso8601
    #   puts fx_turn_over.total_sum
    #   puts fx_turn_over.last_updated
    #
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

    ##
    # Get the list of daily FX turnover for the month
    #
    #   fx_collection = BnmAPI::DailyFXTurnover.by_month(year: 2019, month: 4)
    #
    #   puts fx_collection[0].date.iso8601
    #   puts fx_collection[0].total_sum
    #   puts fx_collection[0].last_updated
    #
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
