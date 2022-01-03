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

    def initialize(calendar, config_schedule)
      @calendar = calendar
      @config_schedule = config_schedule
      @days_config = Hash.new(nil)
      @holidays = @config_schedule[:holiday]
      @anniversaries = @config_schedule[:anniversary]
      @date = @config_schedule[:date]
      
      setup_schedule
    end

    def holidays_in_the_year(holidays)
      holidays.map do |k,v|
        year_of_key = Date.parse(k.to_s).year
        "#{k}: #{v}" if year_of_key == Date.parse(@date.to_s).year
      end.compact
    end

    def show_holidays
      holidays_in_the_year(@holidays)
    end

    def show_anniversaries
      holidays_in_the_year(@anniversaries)
    end

    def setup_schedule
      days_basic
      holidays_in_the_month
      anniversaries_in_the_month
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

      @holidays.keys.grep(regex).each do |d|
        @days_config[d].day = Date.parse(d.to_s).day
        @days_config[d].day_color = :red
        @days_config[d].holiday_text = @holidays[d]
      end
      
      @days_config
    end

    def anniversaries_in_the_month
      y = format("%4d", first_of_month.year)
      m = format("%02d", first_of_month.month)
      regex = /#{y}#{m}\d\d/

      @anniversaries.keys.grep(regex).each do |d|
        @days_config[d].day = Date.parse(d.to_s).day
        @days_config[d].anniversary_text = @anniversaries[d]
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
