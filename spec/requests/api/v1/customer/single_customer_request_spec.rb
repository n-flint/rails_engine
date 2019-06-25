require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'finds a single customer' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bobby', last_name: 'Kelly')
      @customer2 = Customer.create(first_name: 'Bert', last_name: 'Kreischer')
      @customer3 = Customer.create(first_name: 'Bill', last_name: 'Bull', created_at: '2019-06-23 14:53:59 UTC')
    end
    it 'sends a single customer' do
      get "/api/v1/customers/#{@customer1.id}.json"

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer1.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer1.last_name)
    end

    it 'finds a single customer by id' do
      get "/api/v1/customers/find/?id=#{@customer1.id}"

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id']).to eq(@customer1.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer1.last_name)
    end

    it 'finds a single customer by first name' do
      get "/api/v1/customers/find/?first_name=#{@customer2.first_name}"

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id']).to eq(@customer2.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer2.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer2.last_name)
    end

    it 'finds a single customer by last name' do
      get "/api/v1/customers/find/?last_name=#{@customer3.last_name}"

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id']).to eq(@customer3.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer3.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer3.last_name)
    end

    it 'finds a single customer by created_at' do
      get "/api/v1/customers/find/?created_at=#{@customer3.created_at}"

      data = JSON.parse(response.body)

      expect(data['data'][0]['attributes']['id']).to eq(@customer3.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer3.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer3.last_name)
    end
  end
end