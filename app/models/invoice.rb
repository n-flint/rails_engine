class Invoice < ApplicationRecord
  validates_presence_of :customer_id,
                        :merchant_id,
                        :status
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer
  belongs_to :merchant

  default_scope { order('invoices.id ASC')}
end