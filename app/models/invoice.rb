class Invoice < ApplicationRecord
  validates_presence_of :customer_id,
                        :merchant_id,
                        :status

end