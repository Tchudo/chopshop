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
      image_url: helpers.asset_url('lily.png')
    }
    end

  end
end
