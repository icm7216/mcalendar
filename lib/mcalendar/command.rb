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
      begin
        d = Date.parse(@argv.first)
      rescue
        d = Date.today
      end
      
      calendar = Mcalendar::Calendar.new(d.year, d.month)
      calendar.display
      calendar.pdf
    end
  end
end
