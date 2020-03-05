class Event < ApplicationRecord
  has_one_attached :photo
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  def self.all_event_today
    event_count = []
    all_event_range.each do |range|
     event_count << range.include?(Date.today)
    end
    event_count.count(true)
  end

  def self.event_today?
    if self.all_event_today != 0
      return true
    else
      return false
    end
  end

  def self.return_today_event
    event_today = []
    Event.all.each do |event|
      if event.event_range.include?(Date.today)
        event_today << event
      end
    end
    event_today
  end

  def self.all_event_range
    all_event = []
    Event.all.each do |event|
      all_event << (event.start_date..event.end_date)
    end
    all_event
  end


  def day(day)
    relative_day(day)
  end

  def month2
    my_month = self.end_date.month
    relative_month(my_month)
  end

  def month
    my_month = self.start_date.month
    relative_month(my_month)
  end

  def event_range
    (self.start_date.. self.end_date)
  end

  def month_color
    relative_month_color(self.start_date.month)
  end

private

  def relative_day(day)
    case day
    when 0
      "Dimanche"
    when 1
      "Lundi"
    when 2
      "Mardi"
    when 3
      "Mercredi"
    when 4
      "Jeudi"
    when 5
      "Vendredi"
    when 6
      "Samedi"
    end
  end

  def relative_month(month)
    case month
    when 1
      "Janvier"
    when 2
      "Février"
    when 3
      "Mars"
    when 4
      "Avril"
    when 5
      "Mai"
    when 6
      "Juin"
    when 7
      "Juillet"
    when 8
      "Aout"
    when 9
      "Septembre"
    when 10
      "Octobre"
    when 11
      "Novembre"
    when 12
      "Décembre"
    end
  end

  def relative_month_color(month)
    case month
    when 1
      "#9FD8CB"
    when 2
      "#EFD2CB"
    when 3
      "#AFC2D5"
    when 4
      "#F7A072"
    when 5
      "#B48B7D"
    when 6
      "#885053"
    when 7
      ""
    when 8
      "#FABC3C "
    when 9
      "#FE4A49"
    when 10
      "#2C4251"
    when 11
      ""
    when 12
      "#D0E3C4"
    end



  end


end
