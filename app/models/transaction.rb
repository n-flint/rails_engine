class Transaction < ApplicationRecord
  validates_presence_of :credit_card_number,
                        :result
  belongs_to :invoice

  def self.random
    random_id = all.pluck(:id).sample
    Transaction.find(random_id)
  end
end