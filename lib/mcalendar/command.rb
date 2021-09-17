# Ruby Monthly calendar

module Mcalendar
  class Command
    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end
    
    def output_console
      puts @calendar.to_s
    end

    def output_pdf
      @outputpdf.render_file(pdf_filename)
    end

    def output_holidays
      puts "=========== Holidays ==========="
      puts @schedule.show_holidays
      puts "======== Anniversaries ========="
      puts @schedule.show_anniversaries
    end

    def pdf_filename
      if  @pdf_name.nil? || @pdf_name.empty?
        Mcalendar::DEFAULT_PDF_NAME
      else
        @pdf_name = @pdf_name.downcase.end_with?(".pdf")? @pdf_name : @pdf_name + ".pdf"
      end
    end

    def execute
      options = Mcalendar::Options.new.parse(@argv)
      date = options[:date]
      console = options[:console]
      pdf = options[:pdf]
      @pdf_name = options[:name]
      version = options[:version]
      holidays = options[:holidays]

      @calendar = Mcalendar::Calendar.new(date.year, date.month)
      @schedule = Mcalendar::Schedule.new(@calendar, options)
      @outputpdf = Mcalendar::OutputPdf.new(@calendar, @schedule)

      # output calendar
      output_console if console
      output_pdf if pdf
      output_holidays if holidays

      # both outputs if no options
      if console.nil? && pdf.nil? && version.nil? && holidays.nil?
        output_console
        output_pdf
      end
      
    end
  end
end
