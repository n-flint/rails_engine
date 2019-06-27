require 'rails_helper'

RSpec.describe 'Customer Business Intelligence', type: :request do
  before :each do
    @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
    @merchant1 = Merchant.create(name: 'Afroman') 
    @merchant2 = Merchant.create(name: 'Superman') 

    @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
    @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
    @invoice3 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)
    @invoice4 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)

    @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 100, merchant: @merchant1)
    @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 100, merchant: @merchant1)
    @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 200, merchant: @merchant2)
    @item4 = Item.create(name: 'item 4', description: 'item 4 description', unit_price: 200, merchant: @merchant2)

    @invoice_item1 = InvoiceItem.create(invoice: @invoice1, item: @item1, quantity: 10, unit_price: 100)
    @invoice_item2 = InvoiceItem.create(invoice: @invoice2, item: @item2, quantity: 20, unit_price: 200)
    @invoice_item3 = InvoiceItem.create(invoice: @invoice3, item: @item3, quantity: 30, unit_price: 300)
    @invoice_item4 = InvoiceItem.create(invoice: @invoice4, item: @item4, quantity: 40, unit_price: 400)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')  
  end

  it 'returns a customers favorit merchant' do
    get "/api/v1/customers/#{@customer_1.id}/favorite_merchant"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data']['attributes']['id']).to eq(@merchant2.id)
    expect(data['data']['attributes']['name']).to eq(@merchant2.name)
  end
end

# GET /api/v1/customers/:id/favorite_merchant returns a merchant where the customer has conducted the most successful transactions