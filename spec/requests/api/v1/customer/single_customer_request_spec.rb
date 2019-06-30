require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'single customer' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bobby', last_name: 'Kelly')
      @customer2 = Customer.create(first_name: 'Bert', last_name: 'Kreischer')
      @customer3 = Customer.create(first_name: 'Bill', last_name: 'Bull', created_at: '2019-06-23 14:53:59 UTC')
      @customer4 = Customer.create(first_name: 'Bill', last_name: 'Bull', updated_at: '2019-06-25 14:53:59 UTC')
    end
    it 'sends a single customer' do
      get "/api/v1/customers/#{@customer1.id}.json"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer1.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer1.last_name)
    end

    it 'finds a single customer by id' do
      get "/api/v1/customers/find/?id=#{@customer1.id}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer1.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer1.last_name)
    end

    it 'finds a single customer by first name' do
      get "/api/v1/customers/find/?first_name=#{@customer2.first_name}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer2.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer2.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer2.last_name)
    end

    it 'finds a single customer by last name' do
      get "/api/v1/customers/find/?last_name=#{@customer3.last_name}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer3.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer3.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer3.last_name)
    end

    it 'finds a single customer by created_at' do
      get "/api/v1/customers/find/?created_at=#{@customer3.created_at}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer3.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer3.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer3.last_name)
    end

    it 'finds a single customer by updated_at' do
      get "/api/v1/customers/find/?updated_at=#{@customer4.updated_at}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer4.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer4.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer4.last_name)
    end

    it 'finds a random customer' do
      get '/api/v1/customers/random'

      expect(response).to be_successful      
        
      data = JSON.parse(response.body)

      expect(data['data']['attributes'].count).to eq(3)
      expect(data['data']['attributes']).to have_key('id')
      expect(data['data']['attributes']).to have_key('first_name')
      expect(data['data']['attributes']).to have_key('last_name')
    end
  end
end