class Api::V1::Customers::SearchController < ApplicationController

  def show
    render json: CustomerSerializer.new(Customer.where(customer_params))
  end

  private
    def customer_params
      params.permit(:id, :first_name)
    end
end