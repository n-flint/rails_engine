require 'rails_helper'

RSpec.describe 'Merchants API' do
  before :each do
    @merchant1 = Merchant.create(id: 1, name: 'Trevor')
    @merchant2= Merchant.create(name: 'Noah')
    @merchant3 = Merchant.create(name: 'Earl')
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
  end
end