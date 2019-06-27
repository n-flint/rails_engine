require 'rails_helper'

RSpec.describe 'Merchant Business Intelligence', type: :request do
  context 'all merchants' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
      @merchant1 = Merchant.create(name: 'Afroman') 
      @merchant2 = Merchant.create(name: 'Superman') 
      @merchant3 = Merchant.create(name: 'Biggie') 
      @merchant4 = Merchant.create(name: 'Tupac') 

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice3 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)
      @invoice4 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)
      @invoice5 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant3)
      @invoice6 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant3)
      @invoice7 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant4)
      @invoice8 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant4)

      @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 100, merchant: @merchant1)
      @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 100, merchant: @merchant1)
      @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 200, merchant: @merchant2)
      @item4 = Item.create(name: 'item 4', description: 'item 4 description', unit_price: 200, merchant: @merchant2)
      @item5 = Item.create(name: 'item 5', description: 'item 5 description', unit_price: 300, merchant: @merchant3)
      @item6 = Item.create(name: 'item 6', description: 'item 6 description', unit_price: 300, merchant: @merchant3)
      @item7 = Item.create(name: 'item 7', description: 'item 7 description', unit_price: 400, merchant: @merchant4)
      @item8 = Item.create(name: 'item 8', description: 'item 8 description', unit_price: 400, merchant: @merchant4)

      @invoice_item1 = InvoiceItem.create(invoice: @invoice1, item: @item1, quantity: 10, unit_price: 100)
      @invoice_item2 = InvoiceItem.create(invoice: @invoice2, item: @item2, quantity: 20, unit_price: 200)
      @invoice_item3 = InvoiceItem.create(invoice: @invoice3, item: @item3, quantity: 30, unit_price: 300)
      @invoice_item4 = InvoiceItem.create(invoice: @invoice4, item: @item4, quantity: 40, unit_price: 400)
      @invoice_item5 = InvoiceItem.create(invoice: @invoice5, item: @item5, quantity: 5, unit_price: 5000)
      @invoice_item6 = InvoiceItem.create(invoice: @invoice6, item: @item6, quantity: 6, unit_price: 6000)
      @invoice_item7 = InvoiceItem.create(invoice: @invoice7, item: @item7, quantity: 7, unit_price: 7000)
      @invoice_item8 = InvoiceItem.create(invoice: @invoice8, item: @item8, quantity: 8, unit_price: 8000)

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
      @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')
      @transaction5 = Transaction.create(invoice: @invoice5, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction6 = Transaction.create(invoice: @invoice6, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction7 = Transaction.create(invoice: @invoice7, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')
      @transaction8 = Transaction.create(invoice: @invoice8, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    end

    it 'merchants with the most revenue with limit params' do
      limit = 2
      get "/api/v1/merchants/most_revenue?quantity=#{limit}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant4.id)
      expect(data['data'][0]['attributes']['name']).to eq(@merchant4.name)
      expect(data['data'][1]['attributes']['id']).to eq(@merchant3.id)
      expect(data['data'][1]['attributes']['name']).to eq(@merchant3.name)
    end 

    it 'merchants with the most items sold with limit params' do
      limit = 2
      get "/api/v1/merchants/most_items?quantity=#{limit}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant2.id)
      expect(data['data'][0]['attributes']['name']).to eq(@merchant2.name)
      expect(data['data'][1]['attributes']['id']).to eq(@merchant1.id)
      expect(data['data'][1]['attributes']['name']).to eq(@merchant1.name)
    end 

    it 'total ammount sold for a date for all merchants' do
      date = '2019-03-11 14:53:59 UTC'
      
      get "/api/v1/merchants/revenue?date=#{date}"
      
      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']["attributes"]['total_revenue']).to eq(65000)
    end 
  end
end