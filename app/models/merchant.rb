class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  
  def self.random
    random_id = all.pluck(:id).sample
    Merchant.find(random_id)
  end

  def self.most_revenue(limit = 1)
    Merchant.joins(items: {invoice_items: {invoice: :transactions}})
        .where('transactions.result = ?', 'success')
        .group(:id)
        .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue, merchants.*')
        .order('total_revenue DESC')
        .limit(limit)
  end

  def self.most_items(limit = 1)
    Merchant.joins(items: {invoice_items: {invoice: :transactions}})
        .where('transactions.result = ?', 'success')
        .group(:id)
        .select('SUM(invoice_items.quantity) AS total_sold, merchants.*')
        .order('total_sold DESC')
        .limit(limit)
  end
end