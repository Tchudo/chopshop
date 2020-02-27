class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  def create
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy!
    redirect_to favorites_path, :notice => "Your favorite has been deleted"
  end
end
