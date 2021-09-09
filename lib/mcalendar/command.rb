# Ruby Monthly calendar

module Mcalendar
  class Command
    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      @argv = argv
    end

    def execute
      options = Mcalendar::Options.parse(@argv)
      date = options[:date]
      console = options[:opt][:console]
      pdf = options[:opt][:pdf]
      pdf_name = options[:opt][:name]
      version = options[:opt][:version]
      calendar = Mcalendar::Calendar.new(date.year, date.month, pdf_name)

      # output calendar
      calendar.output_console if console
      calendar.output_pdf if pdf

      # both outputs if no options
      if console.nil? && pdf.nil? && version.nil?
        calendar.output_console
        calendar.output_pdf
      end
    end
  end
end
