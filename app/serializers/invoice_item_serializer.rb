class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
    attributes :id, :invoice_id, :item_id, :unit_price, :quantity

    belongs_to :item
    belongs_to :invoice
end