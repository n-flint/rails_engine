class Api::V1::Items::SearchController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.where(item_params))
  end

  private
    def item_params
      params.permit(:id, :name, :description, :unit_price)
    end
end
