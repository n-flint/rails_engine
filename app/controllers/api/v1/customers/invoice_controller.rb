class Api::V1::Customers::InvoiceController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Customer.find(params['id']).invoices)
  end

end