require 'rails_helper'

RSpec.describe 'Items API' do
  context 'multiple items' do
    before :each do
      @merchant1 = Merchant.create(name: 'Trevor')
      @merchant2 = Merchant.create(name: 'Mr. Scooter')
      @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 10000, merchant: @merchant2)
      @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 20000, merchant: @merchant1, created_at: '2012-03-27T14:54:03.000Z')
      @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 30000, merchant: @merchant1, created_at: '2012-03-27T14:54:03.000Z')
      @item4 = Item.create(name: 'item 4', description: 'item 4 description', unit_price: 40000, merchant: @merchant1)
    end

    it 'sends multiple items by created_at' do
      get "/api/v1/items/find_all?created_at=#{@item2.created_at}"

      expect(response).to be_succesful

      items = JSON.parse(response.body)

      expect(items[0]['attributes']['id']).to eq(@item2.id)
      expect(items[1]['attributes']['id']).to eq(@item3.id)
    end
  end
end