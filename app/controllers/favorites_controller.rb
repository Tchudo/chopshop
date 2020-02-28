class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @stock = Stock.find(params[:stock_id])
    @favorite = Favorite.new()
    @favorite.user_id = current_user[:id]
    @favorite.product_id = @stock.product.id

    if @favorite.save!
      redirect_to stocks_path(params[:id])
    else
      render :new
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy!
    redirect_to favorites_path, :notice => "Ce favori a bien été supprimé."
  end
end
