class StocksController < ApplicationController
  def index
    @stocks = Stock.all
    shops_address = []

    @stocks.each do |stock|
      shops_address << stock.shop
    end

    # @product = @stock.find(shop)

    @markers = shops_address.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: shop })
      }
    end
  end

  def show
    @stock = Stock.find(params[:id])

    @markers = [{
        lat: @stock.shop.latitude,
        lng: @stock.shop.longitude
      }]
  end
end
