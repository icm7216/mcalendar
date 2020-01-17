module Mcalendar
  module Config
    COLOR = {
      white:    "FFFFFF",
      silver:   "C0C0C0",
      gray:     "808080",
      black:    "000000",
      red:      "FF0000",
      maroon:   "800000",
      yellow:   "FFFF00",
      olive:    "808000",
      lime:     "00FF00",
      green:    "008000",
      aqua:     "00FFFF",
      teal:     "008080",
      blue:     "0000FF",
      navy:     "000080",
      fuchsia:  "FF00FF",
      purple:   "800080",
      orange:   "FFA500",  
    }

    DAY_OF_WEEK = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    DEFAULT_PDF_NAME = "calendar.pdf"

    Config_day = Struct.new("ConfigDay", :day, :text, :color)

    def self.days_information(obj_calendar)
      @first_of_month = obj_calendar.first_of_month
      @end_of_month = obj_calendar.end_of_month

      @days_config = Hash.new(nil)
      days_basic
      holiday
    end

    def self.days_basic
      (@first_of_month..@end_of_month).each do |date|
        d_sym = date.strftime("%Y%m%d").to_sym
        @days_config[d_sym] = Config_day.new(date.day, " ", :black)
      end
    end

    def self.holiday
      y = "%4d" % @first_of_month.year
      m = "%02d" % @first_of_month.month
      regex = /#{y}#{m}\d\d/
  
      Mcalendar::HOLIDAY.keys.grep(regex).each do |d|
        @days_config[d].day = Date.parse(d.to_s).day
        @days_config[d].text = Mcalendar::HOLIDAY[d]
        @days_config[d].color = :red
      end
    end

    def self.days
      pdf_days = @days_config.each_value.map {|val| val}
      @first_of_month.wday.times {pdf_days.unshift("  ")}
      pdf_days
    end
      
  end
end