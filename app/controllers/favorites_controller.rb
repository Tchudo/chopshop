class FavoritesController < ApplicationController
  def index
    @favorites = Favorite.all
  end

  # def new
  #   @favorite = Favorite.new
  # end

  def create
    raise
    @favorite = Favorite.new(user_id: current_user[:id], product_id: params[:product_id])
    # @favorite.user_id = current_user[:id]
    # @favorite.product_id = params[:id]

    if @favorite.save!
      redirect_to stock_path(params[:id])
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy!
    redirect_to favorites_path, :notice => "Your favorite has been deleted"
  end
end
