module Mcalendar
  class OutputPdf < Prawn::Document
    extend Forwardable
    def_delegator :@calendar, :month_title

    def initialize(calendar, schedule)
      @calendar = calendar
      @schedule = schedule
      
      @month_header = [[month_title]]
      @day_of_week = [Mcalendar::DAY_OF_WEEK] 

    
      @weekly_schedule = @schedule.daily_schedule.each_slice(7).map
      @day_height = @weekly_schedule.size > 5 ? 20 : 20
      @text_height = @weekly_schedule.size > 5 ? 30 : 40
 
      super(page_size: 'A4', margin: 20)
      calendar_render
    end
    
    def month_header
      table(@month_header) do
        cells.style(width: 553, height: 59, align: :center, size: 26)
        row(0).padding_top = 15
        row(0).padding_bottom = 0
      end
    end
    
    def week_header
      table(@day_of_week) do
        cells.style(width: 79, height: 40, align: :center, size: 19)
        row(0).padding_top = 10
        row(0).padding_bottom = 0
        cells[0, 0].text_color = Mcalendar::COLOR[:red]
      end
    end

    def days_schedule
      @weekly_schedule.each do |c|
        row_day = c.map {|x| (x.class == Struct::ConfigDay) ? x.day : x}
        row_color = c.map {|x| (x.class == Struct::ConfigDay) ? x.day_color : :black}
        row_text = c.map do |x|
          str = ""
          if x.class == Struct::ConfigDay
            holiday_str = %Q[<color rgb="#{Mcalendar::COLOR[:red]}">#{x.holiday_text}</color>\n]
            anniversary_str = %Q[<color rgb="#{Mcalendar::COLOR[:green]}">#{x.anniversary_text}</color>]         
            str += holiday_str if x.holiday_text
            str += anniversary_str if x.anniversary_text
          end
          str
        end

        table([row_day], cell_style: {height: @day_height}) do
          cells.style(width: 79, align: :center, size: 19)
          row(0).borders = [:top, :left, :right]
          row(0).padding_top = 2
          row(0).padding_bottom = 0
          row_color.each_with_index do |color, index|
            rows(0).columns(index).text_color = Mcalendar::COLOR[color]
          end
          column(0).map {|col| col.text_color = Mcalendar::COLOR[:red]}
        end

        table([row_text], cell_style: {height: @text_height}) do
          cells.style(width: 79, align: :center, size: 8, overflow: :shrink_to_fit, inline_format: true)
          row(0).borders = [:bottom, :left, :right]
          row(0).padding_top = 0
          row(0).padding_bottom = 0
          row(0).padding_left = 0
          row(0).padding_right = 0
        end
      end
    end

    def calendar_render
      # stroke_axis

      bounding_box([0, 400], width: 553, height: 400) do
        stroke_bounds
        month_header
        week_header
        days_schedule
      end
    end

  end
end
