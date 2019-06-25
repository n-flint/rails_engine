require 'rails_helper'

RSpec.describe 'Customers API' do
  context 'finds multiple customers' do
    before :each do
      @customer1 = Customer.create(first_name: 'Bobby', last_name: 'Kelly')
      @customer2 = Customer.create(first_name: 'Bert', last_name: 'Kreischer')
      @customer3 = Customer.create(first_name: 'Bill', last_name: 'Bull', created_at: '2019-06-23 14:53:59 UTC')
      @customer4 = Customer.create(first_name: 'Bill', last_name: 'Bull', updated_at: '2019-06-25 14:53:59 UTC')
    end
    
    it 'sends a list of customers' do
      get '/api/v1/customers.json'
      
      expect(response).to be_successful

      data = JSON.parse(response.body)

      expect(data['data'].count).to eq(4)
    end
  end
end