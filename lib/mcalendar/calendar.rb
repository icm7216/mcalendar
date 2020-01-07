
module Mcalendar
  class Calendar
    WEEKS = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

    def initialize(year, month)
      @first_of_month = Date.new(year, month, 1)
      @end_of_month = Date.new(year, month, -1)
      @days = (1..@end_of_month.day).map {|m| "%2d" % m}
      @first_of_month.wday.times {@days.unshift("  ")}
    end

    def month_title
      @first_of_month.strftime("%B %Y")
    end

    def to_s
      week_header = WEEKS.join(" ")
      month_header = month_title.center(week_header.size).rstrip
      calendar = [[week_header]]
      @days.each_slice(7) {|x| calendar << [x.join("  ")]}
      [month_header, calendar]
    end
        
    def display
      puts to_s
    end

    def pdf
      month_header = [[month_title]]
      calendar = [WEEKS]
      @days.each_slice(7) {|x| calendar << x}

      pdf = Prawn::Document.new(page_size: 'A4', margin: 20)
      # stroke_axis
      cell_height = calendar.size > 6 ? 50 : 60

      pdf.bounding_box([0, 400], width: 553, height: 400) do
        pdf.stroke_bounds

        pdf.table(month_header) do
          cells.style(width: 553, height: 59, align: :center, size: 26)
          row(0).padding_top = 15
          row(0).padding_bottom = 0
        end
        
        pdf.table(calendar) do
          cells.style(width: 79, height: cell_height, align: :center, size: 19, padding: 15)
          row(0).height = 40
          row(0).padding_top = 10
          row(0).padding_bottom = 0
        end
      end
      pdf.render_file "calendar.pdf"
    end

  end
end
