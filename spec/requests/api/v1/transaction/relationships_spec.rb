require 'rails_helper'

RSpec.describe 'Transactions API' do
  context 'transaction relationships' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
      @merchant1 = Merchant.create(name: 'Afroman') 

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
    end

    it 'can find a transactions invoice' do
      get "/api/v1/transactions/#{@transaction1.id}/invoice"

      expect(response).to be_successful

      data = JSON.parse(response.body)
      
      expect(data['data']['id'].to_i).to eq(@invoice1.id)
      expect(data['data']['attributes']['status']).to eq(@invoice1.status)
    end
  end
end
