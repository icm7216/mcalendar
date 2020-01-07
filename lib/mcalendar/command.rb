# Ruby Monthly calendar

begin
  d = Date.parse(ARGV.first)
rescue
  d = Date.today
end

calendar = Mcalendar::Calendar.new(d.year, d.month)
calendar.display
calendar.pdf
