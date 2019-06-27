require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should have_many :invoice_items}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should belong_to :merchant}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :merchant_id}
  end

  describe 'class methods' do
    it '.random' do
      @merchant1 = Merchant.create(name: 'Trevor')

      @item1 = Item.create(name: 'item 1', description: 'item 1 description', unit_price: 10000, merchant: @merchant1)
      @item2 = Item.create(name: 'item 2', description: 'item 2 description', unit_price: 10000, merchant: @merchant1)
      @item3 = Item.create(name: 'item 3', description: 'item 3 description', unit_price: 10000, merchant: @merchant1)
      
      random_item = Item.random
      expect(random_item.class).to eq(Item)
    end
  end
end