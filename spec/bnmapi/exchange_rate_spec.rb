require 'spec_helper'

RSpec.describe 'BnmAPI::ExchangeRate' do
  describe '#latest' do
    context 'with default session and quote' do
      it 'receive the response' do
        VCR.use_cassette('exchange_rate_latest_default_session_and_quote') do
          fx_rate_collection = BnmAPI::ExchangeRate.latest

          expect(fx_rate_collection.size).to eq(7)

          fx_rate_collection.each do |fx|
            expect(fx.currency_code).not_to be_empty
            expect(fx.unit).to be_kind_of(Numeric)
            expect(fx.date).to be_kind_of(Date)
            expect(fx.buying_rate).to be_kind_of(Numeric)
            expect(fx.selling_rate).to be_kind_of(Numeric)
            expect(fx.quote).to eq('rm')
            expect(fx.last_updated).to be_kind_of(DateTime)
            expect(fx).to respond_to(:middle_rate)
            expect(fx).to respond_to(:session)
          end
        end
      end
    end
  end
end
