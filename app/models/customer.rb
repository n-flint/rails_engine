class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    # returns merchants in incorrect order, works in rails c
    id = self.id.to_s

    Merchant.joins(items: {invoice_items: {invoice: :transactions}}).where('transactions.result = ?', 'success').where('invoices.customer_id =?', id).select('COUNT(merchants.id) AS merchant_count, merchants.*').group(:id).order('merchant_count DESC').limit(1)[0]
  end
end
