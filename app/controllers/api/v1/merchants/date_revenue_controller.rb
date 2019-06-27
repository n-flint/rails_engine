class Api::V1::Merchants::DateRevenueController < ApplicationController

  def show
    render json: RevenueSerializer.new(Merchant.date_revenue(params['date']))
  end
end
