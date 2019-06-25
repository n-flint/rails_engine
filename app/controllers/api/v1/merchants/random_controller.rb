class Api::V1::Merchants::RandomController < ApplicationController

  def show
    # require 'pry'; binding.pry
    # render json: MerchantSerializer.new(Merchant.all.sample)
    render json: MerchantSerializer.new(Merchant.random)
    # test = {json: MerchantSerializer.new(Merchant.first)}
    # render json: MerchantSerializer.new(Merchant.first)
    # require 'pry'; binding.pry

  end

end