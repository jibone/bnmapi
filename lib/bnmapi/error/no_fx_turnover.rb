# frozen_string_literal: true

# :nodoc: all

module BnmAPI::Error # :nodoc: all
  class NoFXTurnover < StandardError
    attr_reader :date

    def initialize(msg: 'No fx turnover on date. endpoint: ', endpoint:)
      @date = date
      super(msg + endpoint)
    end
  end
end
