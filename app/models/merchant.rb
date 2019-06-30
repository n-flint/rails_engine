class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  def total_revenue
    # test = Merchant.joins(items: {invoice_items: {invoice: :transactions}})
    #     .where('transactions.result = ?', 'success')
    #     .group(:id)
    #     .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue, merchants.*')
    #     .order('total_revenue DESC')
    # require 'pry'; binding.pry
    # SELECT SUM(invoice_items.quantity * invoice_items.unit_price) FROM merchants INNER JOIN items ON items.merchant_id = merchants.id INNER JOIN invoice_items ON invoice_items.item_id = items.id INNER JOIN invoices ON invoices.id = invoice_items.invoice_id INNER JOIN transactions ON transactions.invoice_id = invoices.id WHERE merchants.id = 27 AND transactions.result = 'success' GROUP BY merchants.id;
  end

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

  def self.date_revenue(date)
    Invoice.joins(:invoice_items, :transactions)
        .where('transactions.result = ?', 'success')
        .where('transactions.created_at::date = ?', date)
        .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')[0]
  end
end