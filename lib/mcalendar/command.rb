# Ruby Monthly calendar

module Mcalendar
  class Command
    def self.run(argv)
      new(argv).execute
    end

    def initialize(argv)
      # @argv = argv
      options = Mcalendar::Options.new.parse(argv)
      @date = options[:date]
 
      @console = options[:console]
      @pdf = options[:pdf]
      @pdf_name = options[:name]
      @version = options[:version]
      @holidays = options[:holidays]
      @calendar = Mcalendar::Calendar.new(@date.year, @date.month)
      @schedule = Mcalendar::Schedule.new(@calendar, options)
      @wday = options[:wday]
    end
    
    def output_console
      puts @calendar.to_s
    end

    # Number of days for each day of the week in this month.
    def how_many_days
      wdays = Mcalendar::DAY_OF_WEEK.map {|w| w.capitalize + "."}
      wvalues = day_of_weeks.values

      puts "\nNumber of days for each day of the week in #{@date.strftime("%B %Y")}"
      puts "-----------------------------------------------------------------------"
      wdays.each_with_index do |wday, idx|
        puts "#{wday} #{wvalues[idx].size} days. => #{wvalues[idx].join(",")}"
      end
      
    end

    def day_of_weeks
      wks = @calendar.days.each_slice(7).map(&:to_a)     
      keys = Mcalendar::DAY_OF_WEEK.map(&:downcase).map(&:to_sym)

      vals = (0..6).map do |wd|
        w = wks.map {|wk| wk[wd]}
        w.delete("  ")
        w.compact
      end
           
      Hash[keys.zip(vals)]
    end

    def output_pdf
      outputpdf = Mcalendar::OutputPdf.new(@calendar, @schedule)
      outputpdf.render_file(pdf_filename)
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
      # output calendar
      output_console if @console
      output_pdf if @pdf
      output_holidays if @holidays

      # both outputs if no options
      if @console.nil? && @pdf.nil? && @version.nil? && @holidays.nil? && @wday.nil?
        output_console
        output_pdf
      end

      # Number of days for each day of the week in this month.
      how_many_days if @wday
      
    end
  end
end
