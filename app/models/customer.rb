class Customer < ApplicationRecord
  validates_presence_of :first_name,
                        :last_name
  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    id = self.id.to_s

    Merchant.joins(invoices: :transactions)
            .where('transactions.result = ?', 'success')
            .where('invoices.customer_id = ?', id)
            .select('COUNT(transactions.id) AS purchase_count, merchants.*')
            .group(:id)
            .order('purchase_count DESC')[0]
  end
end
