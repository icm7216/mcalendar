require "test_helper"

class McalendarTest < Test::Unit::TestCase
  self.test_order = :defined

  sub_test_case 'Console output calendar' do
  
    setup do
      d = Date.parse("2020/01")      
      @calendar = Mcalendar::Calendar.new(d.year, d.month)
    end
  
    test 'Calendar in 2020/01' do
      assert_equal ["       January 2020", 
        [["Sun Mon Tue Wed Thu Fri Sat"], 
        ["             1   2   3   4"], 
        [" 5   6   7   8   9  10  11"], 
        ["12  13  14  15  16  17  18"], 
        ["19  20  21  22  23  24  25"], 
        ["26  27  28  29  30  31"]]], @calendar.to_s
    end
  end

  sub_test_case 'Console output schedule' do
  
    setup do
      config_schedule = {
        :holiday => {
          :"20210201" => "Day 01",
          :"20210202" => "Day 02",
          :"20210203" => "Day 03",
        },
        :anniversary => {:"20210224"=>"Ruby's Birthday"}
      }
      d = Date.parse("2021/02")      
      calendar = Mcalendar::Calendar.new(d.year, d.month)
      @schedule = Mcalendar::Schedule.new(calendar, config_schedule)
    end
  
    test 'Holidays in 2021/02' do
      expected = [
        "20210201: Day 01", 
        "20210202: Day 02", 
        "20210203: Day 03"
      ]
      assert_equal expected, @schedule.show_holidays
    end

    test 'Anniversaries in 2021/02' do
      expected = ["20210224: Ruby's Birthday"]
      assert_equal expected, @schedule.show_anniversaries
    end
  end

  sub_test_case 'Option parser' do

    setup do
      config_schedule = {
        "anniversary" => {:"20210224"=>"Ruby's Birthday"}
      }
      yaml_object = YAML
      stub(yaml_object).load {config_schedule}
    end
    
    test 'No option' do
      d = Date.today
      args = ['']
      expected = {
        :date => d,
        :holiday => {},
        :anniversary => {:"20210224"=>"Ruby's Birthday"}
      }
      assert_equal expected, Mcalendar::Options.new.parse(args)
    end

    test 'Console option' do    
      d = Date.parse("2021/02")
      args = ["2021/02", "-c"]
      expected = {
        :date => d,
        :console=>true,
        :holiday => {},
        :anniversary => {:"20210224"=>"Ruby's Birthday"}
      }
      assert_equal expected, Mcalendar::Options.new.parse(args)
    end
  end

end
