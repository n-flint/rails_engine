require 'rails_helper'

RSpec.describe 'Merchants API' do
  before :each do
    @merchant1 = Merchant.create(id: 1, name: 'Trevor')
    @merchant2= Merchant.create(name: 'Noah')
    @merchant3 = Merchant.create(name: 'Earl')
  end

  it 'sends a list of merchants' do
    get '/api/v1/merchants.json' 

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data'].count).to eq(3)
  end

  it 'sends a single merchant' do
    get '/api/v1/merchants/1.json'

    expect(response).to be_successful

    data = JSON.parse(response.body)

    expect(data['data']['attributes'].count).to eq(2)
    expect(data['data']['attributes']['id']).to eq(1)
    expect(data['data']['attributes']['name']).to eq('Trevor')
  end
end