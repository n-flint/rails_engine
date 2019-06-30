require 'rails_helper'

RSpec.describe 'Merchants API' do
  context 'merchant relationships' do
    before :each do
      @customer1 = Customer.create(first_name: 'the', last_name: 'customer')
      @merchant1 = Merchant.create(name: 'Afroman') 
      @merchant2= Merchant.create(name: 'Noah')

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice3 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)

      @item1 = Item.create(name: 'item 1', description:'item 1 description', unit_price: '10000')
      @item2 = Item.create(name: 'item 2', description:'item 2 description', unit_price: '20000')

      @merchant1.items << [@item1, @item2]
    end

    it 'can return a merchants items' do
      get "/api/v1/merchants/#{@merchant1.id}/items"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['id'].to_i).to eq(@item1.id)
      expect(data['data'][0]['attributes']['name']).to eq(@item1.name)
      expect(data['data'][0]['attributes']['description']).to eq(@item1.description)
      expect(data['data'][0]['attributes']['unit_price']).to eq(@item1.unit_price)
      expect(data['data'][1]['attributes']['name']).to eq(@item2.name)
    end

    it 'can return a merchants invoices' do
      get "/api/v1/merchants/#{@merchant1.id}/invoices"

      expect(response).to be_successful

      data = JSON.parse(response.body)
      # require 'pry'; binding.pry
      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id'].to_i).to eq(@invoice1.id)
      expect(data['data'][0]['attributes']['status']).to eq(@invoice1.status)
      expect(data['data'][1]['attributes']['id'].to_i).to eq(@invoice2.id)
      expect(data['data'][1]['attributes']['status']).to eq(@invoice2.status)
    end

  end
end