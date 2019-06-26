require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :invoices}
    it {should have_many :items}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    it '.random' do
      @merchant1 = Merchant.create(id: 1, name: 'Trevor')
      @merchant2= Merchant.create(name: 'Noah')
      @merchant3 = Merchant.create(name: 'Earl')
      @merchant4 = Merchant.create(name: 'Schroeder-Jerde')

      random = Merchant.random

      expect(random.class).to eq(Merchant)
    end
  end
end