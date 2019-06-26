class Merchant < ApplicationRecord
  validates_presence_of :name
  has_many :invoices
  has_many :items

  
  def self.random
    # require 'pry'; binding.pry
    random_id = all.pluck(:id).sample
    Merchant.find(random_id)
  end
end