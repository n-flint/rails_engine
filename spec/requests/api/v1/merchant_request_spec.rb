require 'rails_helper'

RSpec.describe 'Merchants API' do
  it 'sends a list of merchants' do
    merchant1 = Merchant.create(name: 'Trevor')
    merchant2= Merchant.create(name: 'Noah')
    merchant3 = Merchant.create(name: 'Earl')
    get '/api/v1/merchants' 

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data'].count).to eq(3)
  end
end