class Api::V1::Customers::TransactionController < ApplicationController

  def index
    render json: TransactionSerializer.new(Customer.find(params['id']).transactions)
  end
end
