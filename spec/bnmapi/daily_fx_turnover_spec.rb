require 'spec_helper'

RSpec.describe 'BnmAPI::DailyFXTurnover' do
  describe '#latest' do
    it 'receive the response' do
      VCR.use_cassette('daily_fx_turnover_latest') do
        fx_turn_over = BnmAPI::DailyFXTurnover.latest

        expect(fx_turn_over.date).to be_kind_of(Date)
        expect(fx_turn_over.total_sum).to eq(11.95)
        expect(fx_turn_over.last_updated).to be_kind_of(DateTime)
      end
    end
  end

  describe '#by_date' do
    context 'and date is a Date object' do
      it 'it parse into the correct string receive the response' do
        VCR.use_cassette('daily_fx_turnover_by_date') do
          date = Date.parse('10-4-2019')
          fx_turn_over = BnmAPI::DailyFXTurnover.by_date(date)

          expect(fx_turn_over.date).to be_kind_of(Date)
          expect(fx_turn_over.total_sum).to eq(12.42)
          expect(fx_turn_over.last_updated).to be_kind_of(DateTime)
        end
      end
    end

    context 'if date is a string' do
      it 'parsed the string and receive the response' do
        VCR.use_cassette('daily_fx_turnover_by_date') do
          fx_turn_over = BnmAPI::DailyFXTurnover.by_date('10-4-2019')

          expect(fx_turn_over.date).to be_kind_of(Date)
          expect(fx_turn_over.total_sum).to eq(12.42)
          expect(fx_turn_over.last_updated).to be_kind_of(DateTime)
        end
      end
    end
  end

  describe '#by_month' do
    it 'retrive a collection of daily fx turnover rates' do
      VCR.use_cassette('daily_fx_turnover_by_month') do
        fx_collection = BnmAPI::DailyFXTurnover.by_month(year: 2019, month: 4)

        expect(fx_collection.size).to eq(10)

        fx_collection.each do |fx|
          expect(fx.date).to be_kind_of(Date)
          expect(fx.total_sum).to be_kind_of(Numeric)
          expect(fx.last_updated).to be_kind_of(DateTime)
        end
      end
    end
  end
end
