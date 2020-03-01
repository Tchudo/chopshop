class SearchesController < ApplicationController

  def index

    Product.reindex # avec "Elastic"
    #@products = Product.all #"Sans Elastic"
   # Product.reindex # avec "Elastic"
  end


  def new

       # ---------------#ElasticSearch
    #@products = Product.search(params[:query])
    if params[:query].nil?
    else
      @products = Product.all
      params[:query].split(" ").each do |word|
        @products = @products.where(id: @products.search(word).map(&:id))
      end
    end
    render :new
  end




end
