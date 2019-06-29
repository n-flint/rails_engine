require 'rails_helper'

RSpec.describe 'Item Business Intelligence', type: :request do
  before :each do
    @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
    @merchant1 = Merchant.create(name: 'Afroman') 
    @merchant2 = Merchant.create(name: 'Superman') 

    @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
    @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
    @invoice3 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)
    @invoice4 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant2)
    @invoice5 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
    @invoice6 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1, created_at: '2019-03-11 14:00:00 UTC')
    @invoice7 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1, created_at: '2019-03-11 14:00:00 UTC')

    @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 100, merchant: @merchant1)
    @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 100, merchant: @merchant1)
    @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 200, merchant: @merchant2)
    @item4 = Item.create(name: 'item 4', description: 'item 4 description', unit_price: 200, merchant: @merchant2)
    @item5 = Item.create(name: 'item 5', description: 'item 5 description', unit_price: 200, merchant: @merchant1)
    @item6 = Item.create(name: 'item 5', description: 'item 5 description', unit_price: 1, merchant: @merchant1)
    # @item7 = Item.create(name: 'item 5', description: 'item 5 description', unit_price: 1, merchant: @merchant1)

    @invoice_item1 = InvoiceItem.create(invoice: @invoice1, item: @item1, quantity: 10, unit_price: 100)
    @invoice_item2 = InvoiceItem.create(invoice: @invoice2, item: @item2, quantity: 20, unit_price: 200)
    @invoice_item3 = InvoiceItem.create(invoice: @invoice3, item: @item3, quantity: 30, unit_price: 300)
    @invoice_item4 = InvoiceItem.create(invoice: @invoice4, item: @item4, quantity: 40, unit_price: 400)
    @invoice_item5 = InvoiceItem.create(invoice: @invoice5, item: @item5, quantity: 50, unit_price: 500)
    @invoice_item6 = InvoiceItem.create(invoice: @invoice6, item: @item6, quantity: 100, unit_price: 1)
    @invoice_item7 = InvoiceItem.create(invoice: @invoice7, item: @item6, quantity: 1, unit_price: 1)

    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
    @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')
    @transaction5 = Transaction.create(invoice: @invoice5, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')
    @transaction6 = Transaction.create(invoice: @invoice6, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')
    @transaction7 = Transaction.create(invoice: @invoice7, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success', created_at: '2019-03-11 14:53:59 UTC')
  end

  it 'returns the top items by total revenue with limit' do
    limit = 2

    get "/api/v1/items/most_revenue?quantity=#{limit}"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data'][0]['attributes']['id']).to eq(@item5.id)
    expect(data['data'][0]['attributes']['name']).to eq(@item5.name)
    expect(data['data'][0]['attributes']['description']).to eq(@item5.description)
    expect(data['data'][0]['attributes']['unit_price']).to eq(@item5.unit_price)
    expect(data['data'][1]['attributes']['id']).to eq(@item4.id)
  end

  it 'returns the top items by number sold with limit' do
    limit = 2

    get "/api/v1/items/most_items?quantity=#{limit}"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data'][0]['attributes']['id']).to eq(@item6.id)
    expect(data['data'][0]['attributes']['name']).to eq(@item6.name)
    expect(data['data'][0]['attributes']['description']).to eq(@item6.description)
    expect(data['data'][0]['attributes']['unit_price']).to eq(@item6.unit_price)
    expect(data['data'][1]['attributes']['id']).to eq(@item5.id)
  end

  xit 'returns the date with most sales for item' do
    get "/api/v1/items/#{@item6.id}/best_day"

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data']['attributes']['date']).to eq('2012-03-11')
  end
end