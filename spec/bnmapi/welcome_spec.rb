require 'spec_helper'

RSpec.describe 'BnmAPI::Welcome.get' do
  it 'receive the response' do
    VCR.use_cassette('welcome') do
      welcome = BnmAPI::Welcome.get

      expect(welcome.name).to eq('BNM.API')
      expect(welcome.api).to eq(['v1'])
      expect(welcome.description).not_to be_empty
      expect(welcome.contact).to eq({
        'name' => 'BNM.API',
        'email' => 'oapi@bnm.gov.my'
      })

      expect(welcome.disclaimer).to eq('https://api.bnm.gov.my/disclaimer')

      expect(welcome.contact_name).to eq('BNM.API')
      expect(welcome.contact_email).to eq('oapi@bnm.gov.my')
    end
  end
end
