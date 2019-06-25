require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'finds a single customer' do
    before :each do
      @customer1 = Customer.create(id: 1, first_name: 'bob', last_name: 'kelly')
    end
    it 'sends a single customer' do
      get 'api/v1/customers/1/.json'

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(1)
      expect(data['data']['attributes']['id']).to eq(@customer.id)
      expect(data['data']['attributes']['first_name']).to eq(@customer1.first_name)
      expect(data['data']['attributes']['last_name']).to eq(@customer1.last_name)
    end
  end
end