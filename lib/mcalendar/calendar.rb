
module Mcalendar
  DEFAULT_PDF_NAME = "calendar.pdf"
  DAY_OF_WEEK = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

  class Calendar
    attr_reader :pdf_name, :month_title, :days

    def initialize(year, month, pdf_name)
      first_of_month = Date.new(year, month, 1)
      end_of_month = Date.new(year, month, -1)
      @days = (1..end_of_month.day).map {|m| "%2d" % m}
      first_of_month.wday.times {@days.unshift("  ")}
      @month_title = first_of_month.strftime("%B %Y")
      set_pdf_name(pdf_name)  
    end
    
    def set_pdf_name(name)
      if  name.nil? || name.empty?
        @pdf_name = Mcalendar::DEFAULT_PDF_NAME
      else
        @pdf_name = name
      end
    end

    def to_s
      week_header = Mcalendar::DAY_OF_WEEK.join(" ")
      month_header = @month_title.center(week_header.size).rstrip
      calendar = [[week_header]]
      @days.each_slice(7) {|x| calendar << [x.join("  ")]}
      [month_header, calendar]
    end
        
    def display
      puts to_s
    end

    def pdf
      pdf = Mcalendar::OutputPdf.new(self)
      pdf.render_file @pdf_name
    end

  end
end
