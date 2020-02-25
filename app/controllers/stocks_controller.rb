class StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end

  def show
    @stock = Stock.find(params[:id])
    @reviews = @stock.reviews

  end


private

  def date?
     @stock.shop.time_tables[0].day_of_week == Time.now.wday
  end
end
