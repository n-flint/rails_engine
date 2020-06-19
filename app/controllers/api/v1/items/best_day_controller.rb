class Api::V1::Items::BestDayController < ApplicationController

  def index
    # require 'pry'; binding.pry
    render json: DateSerializer.new(Item.find(params['id']).best_day)
  end
end