class SearchesController < ApplicationController

  def new
    @stocks = Stock.all
  end
end
