class Api::V1::Items::InvoiceItemsController < ApplicationController

  def index
    # require 'pry'; binding.pry
    render json: InvoiceItemSerializer.new(Item.find(params['id']).invoice_items)
  end

end