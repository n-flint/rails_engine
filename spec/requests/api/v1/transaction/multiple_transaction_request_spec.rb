require 'rails_helper'

RSpec.describe 'Transactions Api' do
  context 'finds multiple transactions' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
      @merchant1 = Merchant.create(name: 'Afroman') 

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice3 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice4 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-04-12', result: 'success')
      @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '1111111111111111', credit_card_expiration_date: '2019-04-10', result: 'success')
      @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '2222222222222222', credit_card_expiration_date: '2019-04-09', result: 'failed')
    end
    
    it 'sends a list of transactions' do
      get '/api/v1/transactions'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(4)
    end

    it 'can find multiple transactions by id' do
      get "/api/v1/transactions/find_all?id=#{@transaction1.id}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id']).to eq(@transaction1.id)
      expect(data['data'][0]['attributes']['credit_card_number']).to eq(@transaction1.credit_card_number)
      expect(data['data'][0]['attributes']['credit_card_expiration_date']).to eq('2019-04-12')
    end
  end
end