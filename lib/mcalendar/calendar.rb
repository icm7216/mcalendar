
module Mcalendar

  class Calendar

    def initialize(year, month)
      @year = year
      @month = month
    end
    
    def first_of_month
      Date.new(@year, @month, 1)
    end
    
    def end_of_month
      Date.new(@year, @month, -1)
    end
    
    def days
      days = (1..end_of_month.day).map {|m| "%2d" % m}
      first_of_month.wday.times {days.unshift("  ")}
      days
    end

    def month_title
      first_of_month.strftime("%B %Y")
    end

    def to_s
      week_header = Mcalendar::DAY_OF_WEEK.join(" ")
      month_header = month_title.center(week_header.size).rstrip
      calendar = [[week_header]]
      days.each_slice(7) {|x| calendar << [x.join("  ")]}
      [month_header, calendar]
    end

  end
end
