require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'customer relationships' do
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

    it 'can return an invoice_items invoice' do
      get "/api/v1/invoice_items/#{@invoice_item1.id}/invoice"

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@invoice1.id)
      expect(data['data']['attributes']['status']).to eq(@invoice1.status)
    end
  end
end
# GET /api/v1/invoice_items/:id/invoice returns the associated invoice
# GET /api/v1/invoice_items/:id/item returns the associated item