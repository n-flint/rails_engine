class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  
  def self.random
    random_id = all.pluck(:id).sample
    Merchant.find(random_id)
  end

  def self.most_revenue(limit = 5)
    # test = Merchant.joins('INNER JOIN items ON items.merchant_id = merchants.id INNER JOIN invoice_items ON invoice_items.item_id = items.id INNER JOIN invoices ON invoices.id = invoice_items.invoice_id INNER JOIN transactions ON transactions.invoice_id = invoices.id')
    #         .where('transactions.result = ?', 'success')
    #         .group(:id)
    #         .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue, merchants.*')
    #         .order('total_revenue DESC')
    #         .limit(limit)
    test = Merchant.joins(:items, [invoices: :transactions])
            .group(:id)
            .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue, merchants.*')
            .order('total_revenue DESC')
            .limit(limit)
  end
end