require 'rails_helper'

RSpec.describe 'Items API' do
  context 'item relationships' do
    before :each do
      @merchant1 = Merchant.create(name: 'Trevor')
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')

      @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 10000, merchant: @merchant1)
      @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 10000, merchant: @merchant1)
      @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 10000, merchant: @merchant1)

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice3 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)

      @invoice_item1 = InvoiceItem.create(invoice: @invoice1, item: @item1, quantity: 1, unit_price: 100)
      @invoice_item2 = InvoiceItem.create(invoice: @invoice2, item: @item2, quantity: 2, unit_price: 200)
      @invoice_item3 = InvoiceItem.create(invoice: @invoice3, item: @item2, quantity: 3, unit_price: 300)
      
    end

    it 'can return an items invoice_items' do
      get "/api/v1/items/#{@item2.id}/invoice_items"

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id']).to eq(@invoice_item2.id)
      expect(data['data'][0]['attributes']['quantity']).to eq(@invoice_item2.quantity)
      expect(data['data'][0]['attributes']['unit_price']).to eq(@invoice_item2.unit_price)

      expect(data['data'][1]['attributes']['id']).to eq(@invoice_item3.id)
      expect(data['data'][1]['attributes']['quantity']).to eq(@invoice_item3.quantity)
      expect(data['data'][1]['attributes']['unit_price']).to eq(@invoice_item3.unit_price)
    end

    it 'can return an items merchant' do
      get "/api/v1/items/#{@item2.id}/merchant"

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@merchant1.id)
      expect(data['data']['attributes']['name']).to eq(@merchant1.name)
    end
  end
end