require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'finds a single customer' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bobby', last_name: 'Kelly')
      @customer2 = Customer.create(first_name: 'Bert', last_name: 'Kreischer')
    end
    it 'sends a single customer' do
      get "/api/v1/customers/#{@customer1.id}.json"

      data = JSON.parse(response.body)

      expect(data['data']['attributes']['id']).to eq(@customer1.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer1.last_name)
    end
  end
end