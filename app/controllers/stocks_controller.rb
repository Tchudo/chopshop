class StocksController < ApplicationController



  def index
    # @products = Product.all
    # params[:query].split(" ").each do |word|
    #   @products = @products.where(id: @products.search(word).map(&:id))
    # end

    # @products = Product.search(params[:query], emoji: true)
    @products = Product.all #'sans Elastic'

    @stocks = []
    @products.each do |product|
      product_stocks = Stock.where(product_id: product.id)
      product_stocks.each do |stock|
        @stocks << stock
      end
    end

      @markers = @stocks.map do |stock|
        {
        lat: stock.shop.latitude,
        lng: stock.shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: stock.shop , product: stock.product, stock: stock}),
        image_url: helpers.asset_url('lily.png')
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
