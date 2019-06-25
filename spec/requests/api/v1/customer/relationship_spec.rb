require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'customer relationships' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
      @customer2 = Customer.create(first_name: 'Joe', last_name: 'Rogan')
      @merchant1 = Merchant.create(name: 'Afroman') 

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice3 = Invoice.create(status: 'shipped', customer: @customer2, merchant: @merchant1)

      @item1 = Item.create(name: 'item 1', description:'item 1 description', unit_price: '10000')
      @item2 = Item.create(name: 'item 2', description:'item 2 description', unit_price: '20000')
      @merchant1.items << [@item1, @item2]

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '12-05-19', result: 'success')

      @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '12341234123412334', credit_card_expiration_date: '12-05-19', result: 'success')
    end

    it 'can return a customers invoices' do
      get "/api/v1/customers/#{@customer1.id}/invoices" 

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['id'].to_i).to eq(@invoice1.id)
      expect(data['data'][0]['attributes']['status']).to eq(@invoice1.status)
      expect(data['data'][1]['id'].to_i).to eq(@invoice2.id)
      expect(data['data'][1]['attributes']['status']).to eq(@invoice2.status)
    end
  end
end
