require 'rails_helper'

RSpec.describe 'Merchants API' do
  context 'finds multiple merchants' do
    before :each do
      @merchant1 = Merchant.create(id: 1, name: 'Cummings-Thiel', created_at: '2019-06-23 14:53:59 UTC')
      @merchant2= Merchant.create(name: 'Noah', created_at: '2019-06-23 14:53:59 UTC')
      @merchant3 = Merchant.create(name: 'Cummings-Thiel', updated_at: '2019-04-24 12:53:59 UTC')
      @merchant4 = Merchant.create(name: 'Schroeder-Jerde', updated_at: '2019-04-24 12:53:59 UTC')
    end

    it 'sends a list of merchants' do
      get '/api/v1/merchants.json' 

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(4)
    end

    it 'can find multiple merchants by name' do
      get '/api/v1/merchants/find_all?name=Cummings-Thiel'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['name']).to eq(@merchant1.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant1.id)
      expect(data['data'][1]['attributes']['name']).to eq(@merchant3.name)
      expect(data['data'][1]['attributes']['id']).to eq(@merchant3.id)
    end

    it 'can find multiple merchants by id' do
      get '/api/v1/merchants/find_all?id=1'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(1)
      expect(data['data'][0]['attributes']['name']).to eq(@merchant1.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant1.id)
    end

    it 'can find multiple merchants by created_at' do
      get '/api/v1/merchants/find_all?created_at=2019-06-23-14:53:59-UTC'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['name']).to eq(@merchant1.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant1.id)
      expect(data['data'][1]['attributes']['name']).to eq(@merchant2.name)
      expect(data['data'][1]['attributes']['id']).to eq(@merchant2.id)
    end

    it 'can find multiple merchants by updated_at' do
      get '/api/v1/merchants/find_all?updated_at=2019-04-24-12:53:59-UTC'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['name']).to eq(@merchant3.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant3.id)
      expect(data['data'][1]['attributes']['name']).to eq(@merchant4.name)
      expect(data['data'][1]['attributes']['id']).to eq(@merchant4.id)
    end
  end
end