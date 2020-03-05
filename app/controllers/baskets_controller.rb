class BasketsController < ApplicationController
  def index
    @baskets = Basket.all



     @stocks_id = []
    # @products.each do |product|
      # product_stocks = Stock.where(product_id: @product.id)
      # basket_stocks = Basket.

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

  def new
    @basket = Basket.new
  end

  def create

    if Stock.find(params[:stock_id]) == nil
      @stock = Stock.find(params[:id])
    else
      @stock = Stock.find(params[:stock_id])
    end

    @basket = Basket.new()
    @basket.user_id = current_user[:id]
    @basket.stock_id = @stock.id


    if @basket.save

    else
      redirect_to baskets_path, :notice => "Ce produit est déjà dans le panier."
    end
  end

  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy!
    redirect_to baskets_path, :notice => "Ce produit a bien été supprimé du panier."
  end
end
