module Mcalendar

  class Schedule
    extend Forwardable
    def_delegators :@calendar, :first_of_month, :end_of_month

    Config_day = Struct.new(
      "ConfigDay",
      :day,
      :day_color,
      :holiday_text,
      :anniversary_text
    )

    def initialize(calendar)
      @calendar = calendar
      @days_config = Hash.new(nil)
      
      setup_schedule
    end

    def setup_schedule
      holiday_description_language
      days_basic
      holidays_in_the_month
      anniversaries_in_the_month
    end

    def holiday_description_language
      Mcalendar.const_set(:HOLIDAY, Mcalendar::EN::HOLIDAY)
      Mcalendar.const_set(:ANNIVERSARY, Mcalendar::EN::ANNIVERSARY)
    end

    def days_basic
      (first_of_month..end_of_month).each do |date|
        d_sym = date.strftime("%Y%m%d").to_sym
        @days_config[d_sym] = Config_day.new(date.day, :black, nil, nil)
      end

      @days_config
    end

    def holidays_in_the_month
      y = format("%4d", first_of_month.year)
      m = format("%02d", first_of_month.month)
      regex = /#{y}#{m}\d\d/

      Mcalendar::HOLIDAY.keys.grep(regex).each do |d|
        @days_config[d].day = Date.parse(d.to_s).day
        @days_config[d].day_color = :red
        @days_config[d].holiday_text = Mcalendar::HOLIDAY[d]
      end
      
      @days_config
    end

    def anniversaries_in_the_month
      y = format("%4d", first_of_month.year)
      m = format("%02d", first_of_month.month)
      regex = /#{y}#{m}\d\d/

      Mcalendar::ANNIVERSARY.keys.grep(regex).each do |d|
        @days_config[d].day = Date.parse(d.to_s).day
        @days_config[d].anniversary_text = Mcalendar::ANNIVERSARY[d]
      end

      @days_config
    end

    def daily_schedule
      daily = @days_config.each_value.map { |val| val }
      first_of_month.wday.times { daily.unshift("  ") }
      daily
    end

  end
end
