module Mcalendar
  class OutputPdf < Prawn::Document

    def initialize(obj_calendar)
      @month_header = [[obj_calendar.month_title]]
      @day_of_week = [Mcalendar::Config::DAY_OF_WEEK] 
      
      @pdf_days = []
      Mcalendar::Config::days_information(obj_calendar)
      @pdf_days = Mcalendar::Config::days
      @calendar = @pdf_days.each_slice(7).map
      @cell_height = @calendar.size > 5 ? 50 : 60
 
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
        cells[0, 0].text_color = Mcalendar::Config::COLOR[:red]
      end
    end

    def day_content
      @calendar.each do |c|
        row_day = c.map {|x| (x.class == Struct::ConfigDay) ? x.day : x}
        row_color = c.map {|x| (x.class == Struct::ConfigDay) ? x.color : :black}
        row_text = c.map {|x| (x.class == Struct::ConfigDay) ? x.text : x}

        table([row_day], cell_style: {height: @cell_height / 2}) do
          cells.style(width: 79, align: :center, size: 19)
          row(0).borders = [:top, :left, :right]
          row(0).padding_top = 5
          row(0).padding_bottom = 0
          row_color.each_with_index do |color, index|
            rows(0).columns(index).text_color = Mcalendar::Config::COLOR[color]
          end
        end

        table([row_text], cell_style: {height: @cell_height / 2}) do
          cells.style(width: 79, align: :center, size: 10)
          row(0).style = {overflow: :shrink_to_fit}
          row(0).borders = [:bottom, :left, :right]
          row(0).padding_top = 1
          row(0).padding_bottom = 0
          row(0).padding_left = 0
          row(0).padding_right = 0
          row_color.each_with_index do |color, index|
            rows(0).columns(index).text_color = Mcalendar::Config::COLOR[color]
          end
        end

      end
    end

    def calendar_render
      # stroke_axis

      bounding_box([0, 400], width: 553, height: 400) do
        stroke_bounds
        month_header
        week_header
        day_content
      end
    end

  end
end
