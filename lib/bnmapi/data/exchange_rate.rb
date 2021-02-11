# frozen_string_literal: true

module BnmAPI::Data # :nodoc: all
  ExchangeRate = Struct.new(
    :currency_code,
    :unit,
    :buying_rate,
    :selling_rate,
    :middle_rate,
    :date_data,
    :quote,
    :session,
    :last_updated_data
  ) do

    def date
      Date.parse(date_data)
    end

    def last_updated
      DateTime.parse(last_updated_data)
    end
  end
end
