require "test_helper"

class McalendarTest < Test::Unit::TestCase
  self.test_order = :defined

  sub_test_case 'calendar text' do
  
    setup do
      d = Date.parse("2020/01")      
      @calendar = Mcalendar::Calendar.new(d.year, d.month)
    end
  
    test '#calendar at 2020/01' do
      assert_equal ["       January 2020", 
        [["Sun Mon Tue Wed Thu Fri Sat"], 
        ["             1   2   3   4"], 
        [" 5   6   7   8   9  10  11"], 
        ["12  13  14  15  16  17  18"], 
        ["19  20  21  22  23  24  25"], 
        ["26  27  28  29  30  31"]]], @calendar.to_s
    end
  end

  sub_test_case 'option parser' do
    
    test '#no option' do
      d = Date.today
      args = ['']
      expected = {:date => d, :opt => {}}
      assert_equal expected, Mcalendar::Options.parse(args)
    end

    test '#full option' do
      d = Date.parse("2020/01")
      args = ["2020/01", "-c", "-p", "-n", "test_pdf"]
      expected = {:date => d, 
        :opt => { :console => true, 
                  :pdf => true, 
                  :name => "test_pdf"}}
      assert_equal expected, Mcalendar::Options.parse(args)
    end
  end

end
