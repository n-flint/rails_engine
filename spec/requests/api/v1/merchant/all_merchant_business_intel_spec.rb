require 'rails_helper'

RSpec.describe 'Merchant Business Intelligence' do
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


      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
      @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')

      @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')

      @transaction5 = Transaction.create(invoice: @invoice5, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction6 = Transaction.create(invoice: @invoice6, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')

      @transaction7 = Transaction.create(invoice: @invoice7, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction8 = Transaction.create(invoice: @invoice8, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')

      @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 10000)
      @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 10000)

      @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 20000)
      @item4 = Item.create(name: 'item 4', description: 'item 4 description', unit_price: 20000)

      @item5 = Item.create(name: 'item 5', description: 'item 5 description', unit_price: 30000)
      @item6 = Item.create(name: 'item 6', description: 'item 6 description', unit_price: 30000)

      @item7 = Item.create(name: 'item 7', description: 'item 7 description', unit_price: 40000)
      @item8 = Item.create(name: 'item 8', description: 'item 8 description', unit_price: 40000)
    end

    it 'merchants with the most revenue with limit params' do
      limit = 2
      get "/api/v1/merchants/most_revenue?quantity=#{limit}"

      expect(response.status).to be_successful

      data = JSON.parse(response.body)
      
      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['id']).to eq(@merchant4.id)
      expect(data['data'][0]['name']).to eq(@merchant4.name)
      expect(data['data'][1]['id']).to eq(@merchant4.id)
      expect(data['data'][1]['name']).to eq(@merchant4.name)
    end 
  end
end