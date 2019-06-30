class InvoiceItemSerializer
  include FastJsonapi::ObjectSerializer
    attributes :id, :invoice_id, :item_id, :quantity

    attribute :unit_price do |object|
      (object.unit_price.to_f / 100).to_s
    end

    belongs_to :item
    belongs_to :invoice
end