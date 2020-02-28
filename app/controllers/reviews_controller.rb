class ReviewsController < ApplicationController

  def new
    @review = Review.new
    @stock = Stock.find(params[:stock_id])
  end

  def create
    @stock = Stock.find(params[:stock_id])
    @review = Review.new(params_review)
    @review.stock_id = @stock.id
    @review.user_id = current_user.id
    if @review.save
      redirect_to stock_path(@stock.id)
    else
      redirect_to stock_path(@stock.id) , notice: "Vous n'avez pas pu donner votre avis sur #{@stock.product.name}"
    end

  end

  private

  def params_review
    params.require(:review).permit(:comment, :rating)
  end
end
