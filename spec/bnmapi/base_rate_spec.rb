require 'spec_helper'

RSpec.describe 'BnmAPI::BaseRate' do
  describe '#latest' do
    it 'receive the response' do
      VCR.use_cassette('base_rate_latest') do
        bank_base_rate_collection = BnmAPI::BaseRate.latest

        expect(bank_base_rate_collection.size).to eq(35)

        bank_base_rate_collection.each do |bank|
          expect(bank.bank_code).not_to be_empty
          expect(bank.bank_name).not_to be_empty
          expect(bank.base_rate).to be_kind_of(Numeric)

          if bank.base_lending_rate == ''
            expect(bank.base_financing_rate).to be_kind_of(Numeric)
          end

          if bank.base_financing_rate == ''
            expect(bank.base_lending_rate).to be_kind_of(Numeric)
          end

          expect(bank.last_updated).to be_kind_of(DateTime)
          expect(bank.effective_date).to be_kind_of(Date)
        end
      end
    end
  end

  describe '#by_bank_code' do
    context 'when bank code exist' do
      it 'receive the response' do
        VCR.use_cassette('base_rate_by_bank_code') do
          rate = BnmAPI::BaseRate.by_bank_code('BKKBMYKL')

          expect(rate.bank_code).to eq('BKKBMYKL')
          expect(rate.bank_name).to eq('Bangkok Bank Berhad')
          expect(rate.base_rate).to eq(4.72)
          expect(rate.base_lending_rate).to eq(7.37)
          expect(rate.indicative_eff_lending_rate).to eq(5.92)

          expect(rate.last_updated).to be_kind_of(DateTime)
          expect(rate.last_updated.iso8601).to eq('2019-01-18T19:25:02+00:00')

          expect(rate.effective_date).to be_kind_of(Date)
          expect(rate.effective_date.iso8601).to eq('2019-04-05')
        end
      end
    end

    context 'when bank code does not exist' do
      it 'raises an exception invalid bank code' do
        VCR.use_cassette('base_rate_by_bank_code_invalid_code') do
          expect {
            BnmAPI::BaseRate.by_bank_code('xxx')
          }.to raise_error(BnmAPI::Error::InvalidBankCode)
        end
      end
    end
  end
end
