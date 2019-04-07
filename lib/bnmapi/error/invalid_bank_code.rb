module BnmAPI::Error
  class InvalidBankCode < StandardError
    attr_reader :bank_code

    def initialize(msg: 'Invalid bank code', bank_code:)
      @bank_code = bank_code
      super(msg + ': ' + bank_code)
    end
  end
end
