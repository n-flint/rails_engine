class Api::V1::CustomersController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.find(params['id']))
  end
end