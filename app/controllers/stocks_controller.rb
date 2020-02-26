class StocksController < ApplicationController
  def index
    @stocks = Stock.all
    shops_address = []

    @stocks.each do |stock|
      shops_address << stock.shop
    end

    # @product = @stock.find(shop)
    # image = image_tag "lily_35.png"

    @markers = shops_address.map do |shop|
      {
        lat: shop.latitude,
        lng: shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: shop , stock: @stocks.find(shop.id)}),
      }
    end
  end

  def show
    @stock = Stock.find(params[:id])
  end
end
