module Mcalendar
  class Options

    def initialize
      @options = {
        :holiday => {}, 
        :anniversary => {}
      }

      # If mcalendar.yml or ~/.mcalendar.yml is not found, load the built-in mcalendar.yml.
      if File.exist?(Mcalendar::DEFAULT_CONFIG_FILE)
        config_yaml = Mcalendar::DEFAULT_CONFIG_FILE
      elsif File.exist?(Mcalendar::GLOBAL_CONFIG_FILE)
        config_yaml = Mcalendar::GLOBAL_CONFIG_FILE
      else
        config_yaml = Mcalendar::BUILT_IN_CONFIG_FILE
      end

      load_config(config_yaml)

    end

    def hash_key_to_sym(h)
      Hash[h.map{|k, v| [k.to_s.to_sym, v]}]
    end

    def load_config(file)
      @config = YAML.load(File.read(file))
      holidays_schedule
      anniversaries_schedule
    end

    def holidays_schedule
      @options[:holiday] = hash_key_to_sym(@config["holiday"]) if @config["holiday"]
    end

    def anniversaries_schedule
      @options[:anniversary] = hash_key_to_sym(@config["anniversary"]) if @config["anniversary"]
    end

    def parse(argv)
      parser = OptionParser.new do |o|
        o.on_head("-v", "--version", "Show version") do |v|
          @options[:version] = v
          o.version = Mcalendar::VERSION
          puts o.version
        end

        o.on("-p", "--pdf", "output pdf") { |v| @options[:pdf] = v }
        
        o.on("-n NAME", "--name=NAME", String, "output pdf name") { |v| @options[:name] = v }
        
        o.on("-c", "--console", "output console") { |v| @options[:console] = v }
        
        o.on("-f FILE", "--config=FILE", "Use YAML format file.") do |file|
          load_config(file) if file and File.exist?(file)
        end

        o.on("-y", "--holidays", "Display holidays and anniversaries in YAML file") { |v| @options[:holidays] = v }
      end

      begin
        remained = parser.parse!(argv)
      rescue OptionParser::InvalidArgument => e
        abort e.message
      rescue OptionParser::MissingArgument => e
        case e.args
        when ["-n"], ["--name"]
          @options[:name] = Mcalendar::DEFAULT_PDF_NAME
        end
      end

      begin
        @options[:date] = Date.parse(remained.first)
      rescue
        @options[:date] = Date.today
      end

      @options
    end

  end
end
