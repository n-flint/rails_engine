class ItemSerializer
  include FastJsonapi::ObjectSerializer
    attributes :id, :name, :description, :merchant_id, :created_at, :updated_at

    attribute :unit_price do |object|
      (object.unit_price.to_f / 100).to_s
    end
    
    belongs_to :merchant
end
