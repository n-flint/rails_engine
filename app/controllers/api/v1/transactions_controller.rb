class Api::V1::TransactionsController < ApplicationController

  def show
    render json: TransactionSerializer.new(Transaction.find(params['id']))
  end

end
