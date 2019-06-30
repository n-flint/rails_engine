class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Merchant.find(params['id']).items.sort_by{ |item| item.id })
  end
end