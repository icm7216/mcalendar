module Mcalendar
  class OutputPdf < Prawn::Document

    def initialize(obj_calendar)
      @month_header = [[obj_calendar.month_title]]
      @day_of_week = [Mcalendar::Config::DAY_OF_WEEK] 
      @calendar = obj_calendar.days.each_slice(7).map
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
        table([c], cell_style: {height: @cell_height / 2}) do
          cells.style(width: 79, align: :center, size: 19)
          row(0).borders = [:top, :left, :right]
          row(0).padding_top = 10
          row(0).padding_bottom = 0
          column(0).map {|c| c.text_color = Mcalendar::Config::COLOR[:red]}
        end

        dummy_text = [""] * c.size
        table([dummy_text], cell_style: {height: @cell_height / 2}) do
          cells.style(width: 79, align: :center, size: 10)
          row(0).style = {overflow: :shrink_to_fit}
          row(0).borders = [:bottom, :left, :right]
          row(0).padding_top = 2
          row(0).padding_bottom = 0
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
