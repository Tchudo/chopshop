class SearchesController < ApplicationController

  def new

    @products = Product.all #"Sans Elastic"
    #@products = Product.reindex # avec "Elastic"
    @events = Event.order(:start_date)

  end









end
