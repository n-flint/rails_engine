class Item < ApplicationRecord
  attr_reader :best_day
  validates_presence_of :name,
                        :description,
                        :unit_price,
                        :merchant_id
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  def self.random
    random_id = pluck(:id).sample
    Item.find(random_id)
  end

  def self.most_revenue(limit = 1)
    self.joins(:invoice_items)
        .select('SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue, items.*')
        .group(:id)
        .order('total_revenue DESC')
        .limit(limit)
  end
  
  def self.most_items(limit = 1)
    self.joins(:invoice_items)
        .select('SUM(invoice_items.quantity) AS total_sold, items.*')
        .group(:id)
        .order('total_sold DESC')
        .limit(limit)
  end

  def best_day
    # id = self.id
    test = Invoice.joins(:invoice_items).where('invoice_items.item_id = ?', self.id).select('SUM(invoice_items.quantity * invoice_items.unit_price) AS daily_revenue, invoices.created_at::date').group('invoices.created_at::date').order('daily_revenue DESC, created_at DESC')[0].created_at.strftime("%Y-%m-%d")
    # yo = {id: 1, best_day: test}
    day = Day.new(test)
    # require 'pry'; binding.pry
    day.best_day
    
    
    # require 'pry'; binding.pry
    # SELECT SUM(invoice_items.quantity * invoice_items.unit_price) AS daily_revenue, invoices.created_at::date FROM "invoices" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" INNER JOIN "invoice_items" ON "invoices"."id" = "invoice_items"."invoice_id" WHERE "invoice_items"."item_id" = 1099 AND transactions.result = 'success' GROUP BY invoices.created_at::date ORDER BY daily_revenue DESC, created_at DESC LIMIT 1;
  
  end
end
