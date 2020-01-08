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
      calendar = Mcalendar::Calendar.new(date.year, date.month, pdf_name)

      # output calendar
      calendar.display if console
      calendar.pdf if pdf

      # both outputs if no options
      if console.nil? && pdf.nil?
        calendar.display
        calendar.pdf
      end
      
    end
  end
end
