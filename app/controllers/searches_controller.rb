class SearchesController < ApplicationController

  def new
    #@products = Product.all #"Sans Elastic"
    Product.reindex #"Elastic"

  end





end
