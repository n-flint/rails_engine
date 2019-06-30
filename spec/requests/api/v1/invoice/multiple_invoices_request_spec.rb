require 'rails_helper'

RSpec.describe 'Invoices API' do
  context 'multiple invoices' do
    before :each do
      @customer1 = Customer.create(first_name: 'Trevor', last_name: 'TrevTrev')

      @merchant1 = Merchant.create(name: 'Trevor')

      @invoice1 = Invoice.create(status: 'shipped', merchant: @merchant1, customer: @customer1)
      @invoice2 = Invoice.create(status: 'shipped', merchant: @merchant1, customer: @customer1)
      @invoice3 = Invoice.create(status: 'shipped', merchant: @merchant1, customer: @customer1)
      @invoice4 = Invoice.create(status: 'shipped', merchant: @merchant1, customer: @customer1)
    end

    it 'sends all invoices' do
      get '/api/v1/invoices'

      expect(response).to be_successful

      invoices = JSON.parse(response.body)['data']
# require 'pry'; binding.pry
      expect(invoices.count).to eq(4)
      expect(invoices[0]['attributes']['id']).to eq(@invoice1.id)
      expect(invoices[1]['attributes']['id']).to eq(@invoice2.id)
      expect(invoices[2]['attributes']['id']).to eq(@invoice3.id)
      expect(invoices[3]['attributes']['id']).to eq(@invoice4.id)  
    end
  end
end