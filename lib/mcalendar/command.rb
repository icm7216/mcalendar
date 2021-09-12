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

    def pdf_filename
      if  @pdf_name.nil? || @pdf_name.empty?
        Mcalendar::DEFAULT_PDF_NAME
      else
        @pdf_name = @pdf_name.downcase.end_with?(".pdf")? @pdf_name : @pdf_name + ".pdf"
      end
    end

    def execute
      options = Mcalendar::Options.parse(@argv)
      date = options[:date]
      console = options[:opt][:console]
      pdf = options[:opt][:pdf]
      @pdf_name = options[:opt][:name]
      version = options[:opt][:version]
      @calendar = Mcalendar::Calendar.new(date.year, date.month)
      @outputpdf = Mcalendar::OutputPdf.new(@calendar)

      # output calendar
      output_console if console
      output_pdf if pdf

      # both outputs if no options
      if console.nil? && pdf.nil? && version.nil?
        output_console
        output_pdf
      end
      
    end
  end
end
