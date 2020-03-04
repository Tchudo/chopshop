class StocksController < ApplicationController



  def index

      # ---------------#ElasticSearch
    # @products = Product.all
    # params[:query].split(" ").each do |word|
    #   @products = @products.where(id: @products.search(word).map(&:id))
    # end

    # @products = Product.search(params[:query], emoji: true)
    #-----------------#ElasticSearch


    #@products = Product.all #'sans Elastic'

   @product = Product.find(params[:search_id])


     @stocks = []
    # @products.each do |product|
      product_stocks =  Stock.where(product_id: @product.id)

      product_stocks.each do |stock|
        @stocks << stock
      end

    @basket = Basket.new
    @basket_user = Basket.where(user_id: current_user[:id]).map(&:stock_id)



      @markers = @stocks.map do |stock|
        {
        lat: stock.shop.latitude,
        lng: stock.shop.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { shop: stock.shop , product: stock.product, stock: stock, basket: @basket}),
        image_url: helpers.asset_url('lily.png')
      }
      end

  end

  def show

    @review = Review.new
    @reviews = Review.where(stock_id: params[:id])

    @favorite = Favorite.new
    @favorite_user = Favorite.where(user_id: current_user[:id]).map(&:product_id)

    @stock = Stock.find(params[:id])
    @product = @stock.product
    @rating = @stock.reviews.map(&:rating)
    @shop = @stock.shop
    @day_of_week = @shop.time_tables.map(&:day_of_week)

    @markers = [{
        lat: @stock.shop.latitude,
        lng: @stock.shop.longitude,
        image_url: helpers.asset_url('lily.png')
    }]

    if @shop.time_tables == []
      @open = "Aucuns horaires"
    else
      gestion_horaire
    end

    if @rating != []
      @rating_score = (@rating.sum / @rating.count).truncate(2)
      rating_star
      rating_half_star
    else
      @star = 0
      @halfstar = 0
      @rating_score = 0
      @rating = 0
    end
  end


private


  ###DATE#####

  def gestion_horaire

    if (open_today? && (Time.now < Time.new(Time.now.year, Time.now.month, Time.now.day, good_opening_hour, 00, 00))) #Matin avant ouverture

        time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, good_opening_hour, 00, 00) - Time.now
        time_hour = time_second / 3600
        hours = time_hour.floor
        minutes = ((time_hour - hours) * 60).to_i
        if minutes.to_s.length < 2
            minutes = "0#{minutes}"
          end
        @open = "Fermé"
        @fermeture = "Ouvre à #{good_opening_hour}:00 (dans #{hours}h:#{minutes}m) "


      elsif open_today? && (Time.now > Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00)) #Soir aprés fermeture
         #!!!!
        if Time.now.wday == @day_of_week.last
                                                                       #Si c'est le dernier jour d'ouverture
          @open = "Fermé"
          @fermeture = "Ouvre #{wich_day(@day_of_week.first)} à #{good_opening_hour}h:00m" #Le else possible
        else                                                                                                       #Si le magasin est ouvert le lendemain
          time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, 23, 59, 59) - Time.now
          time_hour = time_second / 3600
          hours = time_hour.floor + good_opening_hour
          minutes = ((time_hour - hours) * 60).to_i
          if minutes.to_s.length < 2
            minutes = "0#{minutes}"
          end
          @open = "Fermé"
          @fermeture = "Ouvre demain à #{good_opening_hour}h"
        end

        # Dans la plage horaire d'ouverture
      elsif   open_today? && ( (Time.new(Time.now.year, Time.now.month, Time.now.day, good_opening_hour, 00, 00) < Time.now)  && (Time.now < Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00) ) )
        time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00) - Time.now
        time_hour = time_second / 3600
        hours = time_hour.floor
        minutes = ((time_hour - hours) * 60).to_i
        if minutes.to_s.length < 2
            minutes = "0#{minutes}"
          end
        @open = "Ouvert"

        if (Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00) - Time.now <= 4680)    #Si c'est 1h30 avant la fermeture
          @fermeture = "Ferme bientôt. #{good_closing_hour}:00 (dans #{hours}h:#{minutes}m)"
        else
          @fermeture = "Ferme à #{good_closing_hour}:00 (dans #{hours}h:#{minutes}m)"                            #Si il reste plus de 1h30 avant la fermeture
        end
      else
        @open = "Fermé"
        @fermeture = "Ouvre #{wich_day(@day_of_week.first)} à #{good_opening_hour}h:00m"
      end


  end

  def open_today?
    @day_of_week.include?(Time.now.wday)
  end

  def good_opening_hour
      if @opening_hour == nil
        @opening_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = '#{@day_of_week.first}'").first.opened_at
      elsif Time.now.wday != @day_of_week.last
        @opening_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = '#{Time.now.wday + 1}'").first.opened_at
      else
        @opening_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = '#{Time.now.wday}'").first.opened_at
      end
  end

    def good_closing_hour
      @shop.time_tables.find_by(day_of_week: Time.now.wday).closed_at
    end

    def wich_day(date_number)
      case date_number
      when 0
        return "Dimanche"
      when 1
        return "Lundi"
      when 2
        return "Mardi"
      when 3
        return "Mercredi"
      when 4
        return "Jeudi"
      when 5
        return "Vendredi"
      when 6
        return "Samedi"
      end
    end


  #Rating######

  def rating_star
    if @rating.count > 0
      @star = @rating.sum / @rating.count
    else
      @star = 0
    end
  end

  def rating_half_star
    if @star > 1
      rating_score = (@rating.sum / @rating.count).to_s.split(",")
      rating_integer = rating_score[0].to_i
      rating_float = rating_score[1].to_f
      if rating_float >= 0.7 && rating_float <= 0.3
        return @halfstar = 1
      else
        return @halfstar = 0
      end
    else
      @halfstar = 0
    end
  end

end
