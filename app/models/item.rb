class Item < ApplicationRecord
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
end
