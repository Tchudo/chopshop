class BasketsController < ApplicationController
  def index
    @baskets = Basket.all
  end

  def new
    @basket = Basket.new
  end

  def create
    @stock = Stock.find(params[:stock_id])
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
