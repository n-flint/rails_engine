require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'relationships'do
    it {should belong_to :invoice}
  end
  describe 'validations' do
    it {should validate_presence_of :invoice_id}
    it {should validate_presence_of :credit_card_number}
    it {should validate_presence_of :credit_card_expiration_date}
    it {should validate_presence_of :result}
  end

  describe 'class methods' do
    it '.random' do
      @customer1 = Customer.create(first_name: 'Bill', last_name: 'Burr')
      @merchant1 = Merchant.create(name: 'Afroman') 

      @invoice1 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)
      @invoice2 = Invoice.create(status: 'shipped', customer: @customer1, merchant: @merchant1)

      @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '12341234123412334', credit_card_expiration_date: '2019-05-12', result: 'success')
      @transaction2 = Transaction.create(invoice: @invoice1, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction3 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      @transaction4 = Transaction.create(invoice: @invoice2, credit_card_number: '00000000000000000', credit_card_expiration_date: '2019-04-11', result: 'success')
      
      random_transaction = Transaction.random

      expect(random_transaction.class).to eq(Transaction)
    end
  end
end
