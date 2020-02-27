class StocksController < ApplicationController
  def index
    #@products = Product.search(params[:query]) "Elastic"
    @products = Product.all #'sans Elastic'
    @products.each do |product|
      @stocks = Stock.where(product_id: product.id)
      @markers = @stocks.map do |stock|
        {
        lat: stock.shop.latitude,
        lng: stock.shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: stock.shop , stock: stock}),
        image_url: helpers.asset_url('lily.png')
      }
      end
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
