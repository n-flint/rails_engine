class Api::V1::Merchants::SearchController < ApplicationController
  def show
    render json: MerchantSerializer.new(Merchant.where(merchant_params))
  end


  private
    def merchant_params
      params.permit(:name)
    end
end