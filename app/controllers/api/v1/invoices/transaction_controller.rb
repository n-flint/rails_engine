class Api::V1::Invoices::TransactionController < ApplicationController

  def index
    render json: TransactionSerializer.new(Invoice.find(params['id']).transactions)
  end
end