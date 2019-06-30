require 'rails_helper'

RSpec.describe 'Invoices API' do
  context 'invoice relationships' do
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
      @invoice_item3 = InvoiceItem.create(invoice: @invoice2, item: @item3, quantity: 3, unit_price: 300)

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
      @transaction2 = Transaction.create(invoice: @invoice1, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    end
    
    it 'can return an invoices transactions' do
      get "/api/v1/invoices/#{@invoice1.id}/transactions"

      data = JSON.parse(response.body)

      expect(data['data'][0]['id'].to_i).to eq(@transaction1.id)
      expect(data['data'][0]['attributes']['credit_card_number']).to eq(@transaction1.credit_card_number)
      expect(data['data'][0]['attributes']['result']).to eq(@transaction1.result)

      expect(data['data'][1]['id'].to_i).to eq(@transaction2.id)
      expect(data['data'][1]['attributes']['credit_card_number']).to eq(@transaction2.credit_card_number)
      expect(data['data'][1]['attributes']['result']).to eq(@transaction2.result)
    end

    it 'can return an invoices invoice_items' do
      get "/api/v1/invoices/#{@invoice2.id}/invoice_items"

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id'].to_i).to eq(@invoice_item2.id)
      expect(data['data'][0]['attributes']['quantity'].to_i).to eq(@invoice_item2.quantity)
      expect(data['data'][0]['attributes']['unit_price'].to_i).to eq(@invoice_item2.unit_price)
    
      expect(data['data'][1]['attributes']['id'].to_i).to eq(@invoice_item3.id)
      expect(data['data'][1]['attributes']['quantity'].to_i).to eq(@invoice_item3.quantity)
      expect(data['data'][1]['attributes']['unit_price'].to_i).to eq(@invoice_item3.unit_price)
    end

    it 'can return an invoices items' do
      get "/api/v1/invoices/#{@invoice2.id}/items"

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id']).to eq(@item2.id)
      expect(data['data'][0]['attributes']['name']).to eq(@item2.name)
      expect(data['data'][0]['attributes']['description']).to eq(@item2.description)
      expect(data['data'][0]['attributes']['unit_price']).to eq(@item2.unit_price)

      expect(data['data'][1]['attributes']['id']).to eq(@item3.id)
      expect(data['data'][1]['attributes']['name']).to eq(@item3.name)
      expect(data['data'][1]['attributes']['description']).to eq(@item3.description)
      expect(data['data'][1]['attributes']['unit_price']).to eq(@item3.unit_price)
    end

    it 'can return an invoices customer' do
      get "/api/v1/invoices/#{@invoice3.id}/customer"

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer1.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer1.last_name)
    end

    it 'can return an invoices merchant' do
      get "/api/v1/invoices/#{@invoice3.id}/merchant"

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@merchant1.id)
      expect(data['data']['attributes']['name']).to eq(@merchant1.name)
    end
  end
end