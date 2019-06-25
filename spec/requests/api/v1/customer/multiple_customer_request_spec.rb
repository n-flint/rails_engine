require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'finds multiple customers' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bobby', last_name: 'Kelly', created_at: '2019-06-23 14:53:59 UTC')
      @customer2 = Customer.create(first_name: 'Bert', last_name: 'Kreischer')
      @customer3 = Customer.create(first_name: 'Bill', last_name: 'Bull', created_at: '2019-06-23 14:53:59 UTC')
      @customer4 = Customer.create(first_name: 'Bill', last_name: 'Burr', updated_at: '2019-06-25 14:53:59 UTC')
      @customer5 = Customer.create(first_name: 'Bobby', last_name: 'Burr', updated_at: '2019-06-25 14:53:59 UTC')
    end
    
    it 'sends a list of customers' do
      get '/api/v1/customers.json'
      
      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(5)
    end

    it 'can find multiple customers by id' do
      get "/api/v1/customers/find_all?id=#{@customer1.id}"

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(1)
      expect(data['data'][0]['attributes']['id']).to eq(@customer1.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer1.last_name)
    end

    it 'can find multiple customers by first name' do
      get '/api/v1/customers/find_all?first_name=Bill'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id']).to eq(@customer3.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer3.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer3.last_name)
      expect(data['data'][1]['attributes']['id']).to eq(@customer4.id)
      expect(data['data'][1]['attributes']['first_name']).to eq(@customer4.first_name)
      expect(data['data'][1]['attributes']['last_name']).to eq(@customer4.last_name)
    end

    it 'can find multiple customers by last name' do
      get '/api/v1/customers/find_all?last_name=Burr'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id']).to eq(@customer4.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer4.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer4.last_name)
      expect(data['data'][1]['attributes']['id']).to eq(@customer5.id)
      expect(data['data'][1]['attributes']['first_name']).to eq(@customer5.first_name)
      expect(data['data'][1]['attributes']['last_name']).to eq(@customer5.last_name)
    end

    it 'can find multiple customers by created_at' do
      get '/api/v1/customers/find_all?created_at=2019-06-23-14:53:59-UTC'

      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(2)
      expect(data['data'][0]['attributes']['id']).to eq(@customer1.id)
      expect(data['data'][0]['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data'][0]['attributes']['last_name']).to eq(@customer1.last_name)
      expect(data['data'][1]['attributes']['id']).to eq(@customer3.id)
      expect(data['data'][1]['attributes']['first_name']).to eq(@customer3.first_name)
      expect(data['data'][1]['attributes']['last_name']).to eq(@customer3.last_name)
    end
  end
end