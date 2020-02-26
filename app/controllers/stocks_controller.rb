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
    @day = nil
    @hours = nil
    @minutes = nil
    @open = nil


    @opening_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = 6").first.opened_at
    @closing_hour = TimeTable.where("shop_id = '#{@shop.id}' and day_of_week = 6").first.closed_at


    if date? && Time.now < Time.new(Time.now.year, Time.now.month, Time.now.day, @closing_hour, 00, 00)  #dans le cas ou on est le matin avant l'heure
      time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, @closing_hour, 00, 00) - Time.now
      time_hour = time_second / 3600
      @hours = time_hour.floor
      @minutes = ((time_hour - @hours) * 60).to_i
      @open = "fermé"

    elsif date? && (  (Time.new(Time.now.year, Time.now.month, Time.now.day, @opening_hour, 00, 00) < Time.now)      && (Time.now < Time.new(Time.now.year, Time.now.month, Time.now.day, @closing_hour, 00, 00)))
      raise
      @open = true
      time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, @closing_hour, 00, 00) - Time.now
      time_hour = time_second / 3600
      @hours = time_hour.floor
      @minutes = ((time_hour - @hours) * 60).to_i
      @open = "ouvert"

    elsif date? && Time.now > Time.new(Time.now.year, Time.now.month, Time.now.day, @closing_hour, 00, 00)
      if Time.now.wday == @day_of_week.last
        @open = false
        @day = "Ouvre Lundi à 8h00"
      else
        time_second = Time.new(Time.now.year, Time.now.month, Time.now.day, 23, 59, 59) - Time.now
        time_hour = time_second / 3600
        @hours = time_hour.floor + @opening_hour
        @minutes = ((time_hour - @hours) * 60).to_i
        @open = "fermé"
      end
    end
      # split_time = time_hour.to_s.split(".")
      # hour = split_time[0]
      # minutes_step_one = 0,split_time[1].to_i




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
      rating_float >= 0.5 ? @halfstar = 1 : @halfstar = 0
    else
      @halfstar = 0
    end
  end

end
