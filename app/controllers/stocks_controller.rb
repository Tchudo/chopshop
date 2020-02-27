class StocksController < ApplicationController
  def index
    @stocks = Stock.all
  end

  def show
    @stock = Stock.find(params[:id])
    @rating = @stock.reviews.map(&:rating)
    @stars = 0
    @shop = @stock.shop
    @shop_time_table = @stock.shop.time_tables
    @day_of_week = @shop_time_table.map(&:day_of_week)
    @day_of_week_range = (@day_of_week.first..@day_of_week.last)

    if (date? && (Time.now < Time.new(Time.now.year, Time.now.month, Time.now.day, good_opening_hour, 00, 00))) #Matin avant ouverture


      time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, good_opening_hour, 00, 00) - Time.now
      time_hour = time_second / 3600
      hours = time_hour.floor
      minutes = ((time_hour - hours) * 60).to_i
      @open = "Fermé"
      @fermeture = " . Ouvre à #{good_opening_hour}:00 (dans #{hours}h:#{minutes}m) "


    elsif date? && (Time.now > Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00)) #Soir aprés fermeture
       #!!!!
      if Time.now.wday == @day_of_week.last
                                                                     #Si c'est le dernier jour d'ouverture
        @open = "Fermé"
        @fermeture = " . Ouvre #{wich_day(@day_of_week.first)} à #{good_opening_hour}h:00m" #Le else possible
      else                                                                                                       #Si le magasin est ouvert le lendemain
        time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, 23, 59, 59) - Time.now
        time_hour = time_second / 3600
        hours = time_hour.floor + good_opening_hour
        minutes = ((time_hour - hours) * 60).to_i
        @open = "Fermé"
        @fermeture = " . Ouvre demain à #{good_opening_hour}"
      end

      # Dans la plage horaire d'ouverture
    elsif   date? && ( (Time.new(Time.now.year, Time.now.month, Time.now.day, good_opening_hour, 00, 00) < Time.now)  && (Time.now < Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00) ) )
      time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00) - Time.now
      time_hour = time_second / 3600
      hours = time_hour.floor
      minutes = ((time_hour - hours) * 60).to_i
      @open = "Ouvert"

      if (Time.new(Time.now.year, Time.now.month, Time.now.day, good_closing_hour, 00, 00) - Time.now <= 4680)    #Si c'est 1h30 avant la fermeture
        @fermeture = "Ferme bientôt . #{good_closing_hour}:00 (dans #{hours}:#{minutes}))"
      else
        @fermeture = " . Ferme à #{good_closing_hour}:00 (dans #{hours}h:#{minutes}m)"                            #Si il reste plus de 1h30 avant la fermeture
      end
    end





    # @reviews = @stock.reviews
    # shop = @stock.shop
    # day_open = shop.table_times.map[&:day_of_week]
    rating_star
    rating_half_star

    # if date? && DateTime.now.hour >
  end

  # def opened?
  #   daytime_compare = (day_open.first..day_open.last).include?(DateTime.now.wday)
  #   if daytime_compare &&

  # end


private

  ###DATE#####

  def date?
    @day_of_week_range.include?(Time.now.wday)
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
      # if @closing_hour == nil
      #   @closing_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = '#{@day_of_week.first}'").first.closed_at
      # else
      #   @closing_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = '#{Time.now.wday}'").first.closed_at
      # end
      @shop.time_tables.find_by(day_of_week: Time.now.wday).closed_at
    end

    def wich_day(date_number)
      case date_number
      when 0
        return "Sunday"
      when 1
        return "Monday"
      when 2
        return "Tuesday"
      when 3
        return "Wednesday"
      when 4
        return "Thursday"
      when 5
        return "Friday"
      when 6
        return "Saturday"
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
