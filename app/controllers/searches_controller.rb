class SearchesController < ApplicationController

  def new

    #@products = Product.all #"Sans Elastic"
    @products = Product.reindex # avec "Elastic"

  end





end
