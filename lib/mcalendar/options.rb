module Mcalendar
  module Options
    def self.parse(argv)
      options = {}

      parser = OptionParser.new do |o|
        o.on_head("-v", "--version", "Show version") do |v|
          options[:version] = v
          o.version = Mcalendar::VERSION
          puts o.version
        end
        o.on("-p", "--pdf", "output pdf") { |v| options[:pdf] = v }
        o.on("-n NAME", "--name=NAME", String, "output pdf name") { |v| options[:name] = v }
        o.on("-c", "--console", "output console") { |v| options[:console] = v }
      end

      begin
        remained = parser.parse!(argv)
      rescue OptionParser::InvalidArgument => e
        abort e.message
      rescue OptionParser::MissingArgument => e
        case e.args
        when ["-n"], ["--name"]
          options[:name] = Mcalendar::DEFAULT_PDF_NAME
        end
      end

      begin
        d = Date.parse(remained.first)
      rescue
        d = Date.today
      end

      { date: d, opt: options }
    end
  end
end
