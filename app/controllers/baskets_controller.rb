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
    @basket.product_id = @stock.product.id

    if @basket.save
      redirect_to stock_path(@stock.id), :notice => "Ce produit a bien été ajouté au panier."
    else
      redirect_to stock_path(@stock.id), :notice => "Ce produit est déjà dans le panier."
    end
  end

  def destroy
    @basket = Basket.find(params[:id])
    @basket.destroy!
    redirect_to baskets_path, :notice => "Ce produit a bien été supprimé du panier."
  end
end
