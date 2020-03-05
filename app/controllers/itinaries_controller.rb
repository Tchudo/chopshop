class ItinariesController < ApplicationController
  def index
  @baskets = Basket.all

   @stocks_id = []

    @baskets.each do |basket|
      @stocks_id << basket.stock_id
    end

    @stocks = Stock.where(id: @stocks_id)

    @shops_id = []
    @stocks.each do |stock|
      @shops_id << stock.shop_id
    end

    @shops = Shop.where(id: @shops_id)


    @markers = @shops.map do |shop|
      {
      lat: shop.latitude,
      lng: shop.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { shop: shop, stock: Stock.where(shop_id: shop.id), product: Product.where(id: Stock.where(shop_id: shop.id)[0].product_id)}),
      image_url: helpers.asset_url('lily_omb.png')
    }
    end

  end
end
