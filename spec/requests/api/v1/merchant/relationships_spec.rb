require 'rails_helper'

RSpec.describe 'Merchants API' do
  context 'merchant relationships' do
    before :each do
      @customer1 = Customer.create(first_name: 'the', last_name: 'customer')
      @merchant1 = Merchant.create(name: 'Afroman') 
      @merchant2= Merchant.create(name: 'Noah')

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer2)

      @item1 = Item.create(name: 'item 1', description:'item 1 description', unit_price: '10000')
      @item2 = Item.create(name: 'item 2', description:'item 2 description', unit_price: '20000')

      @merchant1.items << [@item1, @item2]
      @merchant1.invoices << [@invoice1, @invoice2]
    end

    it 'can return a merchants items' do
      get "/api/v1/merchants/#{@merchant1.id}/items"

      expect(response).to be_succsessful

      data = JSON.parse(response.body)

      expect(data['data']['items'].count).to eq(2)
    end

  end
end