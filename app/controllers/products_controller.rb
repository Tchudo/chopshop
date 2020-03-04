class ProductsController < ApplicationController

  def index
  end

 # GET /products/new
  def new
    @product = Product.new
    @product.upc = params[:upc]
  end


  # POST /products/get_barcode
  def get_barcode

    id = Product.where(product_sku: params[:upc]).ids[0]
    p id

    if id.nil?
      redirect_to products_path
    else
      @product = Product.find(id)
      redirect_to search_stocks_path(@product)
    end
  end

end
