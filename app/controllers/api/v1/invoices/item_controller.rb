class Api::V1::Invoices::ItemController < ApplicationController

  def index
    render json: ItemSerializer.new(Invoice.find(params['id']).items)
  end
end
