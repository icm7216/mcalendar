module Mcalendar
  module Options

    def self.parse(argv)
      parser = OptionParser.new do |o|
        o.on_head('-v', '--version', 'Show version') do
          o.version = Mcalendar::VERSION
          puts o.version
          exit
        end

        o.on('-p', '--pdf', 'output pdf') do

          puts "--pdf option"
          exit
        end

        o.on('-c', '--console', 'output console') do

          puts "--console option"
          exit
        end


      end  

      parser.parse!(argv)
    end
  end
end
