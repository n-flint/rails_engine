require 'rails_helper'

RSpec.describe 'Transactions API' do
  context 'single transaction' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
      @merchant1 = Merchant.create(name: 'Afroman') 

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
      @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    end

    it 'sends a single transaction' do
      get "/api/v1/transactions/#{@transaction1.id}.json"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['id'].to_i).to eq(@transaction1.id)
      expect(data['data']['attributes']['credit_card_number']).to eq(@transaction1.credit_card_number)
      expect(data['data']['attributes']['result']).to eq(@transaction1.result)
    end

    it 'finds a single transaction by id' do
      get "/api/v1/transactions/find?id=#{@transaction1.id}.json"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'][0]['id'].to_i).to eq(@transaction1.id)
      expect(data['data'][0]['attributes']['credit_card_number']).to eq(@transaction1.credit_card_number)
      expect(data['data'][0]['attributes']['result']).to eq(@transaction1.result)
    end

    it 'finds a random transaction' do
      get "/api/v1/transactions/random"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']).to have_key('credit_card_number')
      expect(data['data']['attributes']).to have_key('result')
    end
  end
end