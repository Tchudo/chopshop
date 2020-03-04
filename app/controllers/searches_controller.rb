class SearchesController < ApplicationController

  def index
    #Product.reindex # avec "Elastic"
    #@products = Product.all #"Sans Elastic"
   # Product.reindex # avec "Elastic"
     @events = Event.order(:start_date)
  end


   


  def new
  end

  def create
    #@products = Product.all
    @products = Product.searchable_by(params[:query])

      respond_to do |format|
        format.html { redirect_to root_path }
        format.js  # <-- will render `app/views/searches/create.js.erb`
      end
  end






end
