module BnmAPI::Error
  class NoFXTurnover < StandardError
    attr_reader :date

    def initialize(msg: 'No fx turnover on date. endpoint: ', endpoint:)
      @date = date
      super(msg + endpoint)
    end
  end
end
