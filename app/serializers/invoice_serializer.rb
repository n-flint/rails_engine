class InvoiceSerializer
  include FastJsonapi::ObjectSerializer
    attributes :id, :status, :merchant_id, :customer_id

    belongs_to :merchant
    belongs_to :customer
end