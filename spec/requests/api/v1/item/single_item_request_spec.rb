require 'rails_helper'

RSpec.describe 'Items API' do
  context 'single item' do
    before :each do
      @merchant1 = Merchant.create(name: 'Trevor')
      @merchant2 = Merchant.create(name: 'Bill')
      @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 10000, merchant: @merchant1)
      @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 20000, merchant: @merchant2)

    end
    it 'sends a single item' do
      get "/api/v1/items/#{@item1.id}.json"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@item1.id)
      expect(data['data']['attributes']['name']).to eq(@item1.name)
      expect(data['data']['attributes']['description']).to eq(@item1.description)
      expect(data['data']['attributes']['description']).to eq(@item1.description)
      expect(data['data']['attributes']['unit_price']).to eq(@item1.unit_price)
    end
  end
end