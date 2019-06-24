require 'rails_helper'

RSpec.describe 'Merchants API' do
  context 'finds a single merchant' do
    before :each do
      @merchant1 = Merchant.create(id: 1, name: 'Trevor')
      @merchant2= Merchant.create(name: 'Noah', created_at: '2019-06-23 14:53:59 UTC')
      @merchant3 = Merchant.create(name: 'Earl', updated_at: '2019-04-24 12:53:59 UTC')
      @merchant4 = Merchant.create(name: 'Schroeder-Jerde')
    end

    it 'sends a list of merchants' do
      get '/api/v1/merchants.json' 

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(4)
    end

    it 'sends a single merchant' do
      get '/api/v1/merchants/1.json'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes'].count).to eq(2)
      expect(data['data']['attributes']['id']).to eq(1)
      expect(data['data']['attributes']['name']).to eq(@merchant1.name)
    end

    it 'finds a single merchant by name' do
      get '/api/v1/merchants/find?name=Schroeder-Jerde'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['name']).to eq(@merchant4.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant4.id)
    end

    it 'finds a single merchant by id' do
      get '/api/v1/merchants/find?id=1'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['name']).to eq(@merchant1.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant1.id)
    end

    it 'finds a single merchant by created_at' do
      get '/api/v1/merchants/find?created_at=2019-06-23-14:53:59-UTC'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['name']).to eq(@merchant2.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant2.id)
    end

    it 'finds a single merchant by updated_at' do
      get '/api/v1/merchants/find?updated_at=2019-04-24-12:53:59-UTC'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['name']).to eq(@merchant3.name)
      expect(data['data'][0]['attributes']['id']).to eq(@merchant3.id)
    end

    it 'finds a random merchant' do
      get '/api/v1/merchants/random' do
      
      expect(response).to be_succsessful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(1)
      expect(data['data'][0]['attributes'].count).to eq(2)
      expect(data['data'][0]['attributes']).to have_key('id')
      expect(data['data'][0]['attributes']).to have_key('name')
      end
    end
  end
end