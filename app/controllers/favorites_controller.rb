class FavoritesController < ApplicationController
  def index
    @product = Product.first #test de cloudinary (à dégager)
  end

  def create
  end
end
