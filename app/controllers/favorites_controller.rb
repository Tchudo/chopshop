class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
    @favorites.each do |favorite|
      @stock = Stock.where(product_id: favorite.product_id)
    end
  end

  def new
    @favorite = Favorite.new
  end

  def create
    @stock = Stock.find(params[:stock_id])
    @favorite = Favorite.new()
    @favorite.user_id = current_user[:id]
    @favorite.product_id = @stock.product.id

    if @favorite.save
      redirect_to stock_path(@stock.id), :notice => "Ce produit a bien été ajouté."
    else
      redirect_to stock_path(@stock.id), :notice => "Ce produit est déjà dans les favoris."
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy!
    redirect_to favorites_path, :notice => "Ce favori a bien été supprimé."
  end
end
