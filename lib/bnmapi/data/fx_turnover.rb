# frozen_string_literal: true

module BnmAPI::Data # :nodoc: all
  FXTurnover = Struct.new(
    :total_sum,
    :date_data,
    :last_updated_data
  ) do

    def last_updated
      DateTime.parse(last_updated_data)
    end

    def date
      Date.parse(date_data)
    end
  end
end
