namespace :import do
  desc  "rake import data from merchant csv files"
  task generic: :environment do
    require 'csv'
    CSV.foreach('./data/merchants.csv', :headers => true) do |row|
      Merchant.create(row.to_h)
    end
    CSV.foreach('./data/customers.csv', :headers => true) do |row|
      Customer.create(row.to_h)
    end
    CSV.foreach('./data/items.csv', :headers => true) do |row|
      Item.create(row.to_h)
    end
    CSV.foreach('./data/invoices.csv', :headers => true) do |row|
      Invoice.create(row.to_h)
    end
    CSV.foreach('./data/invoice_items.csv', :headers => true) do |row|
      InvoiceItem.create(row.to_h)
    end
    CSV.foreach('./data/transactions.csv', :headers => true) do |row|
      Transaction.create(row.to_h)
    end
  end
end
