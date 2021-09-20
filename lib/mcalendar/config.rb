module Mcalendar
  COLOR = {
    white: "FFFFFF",
    silver: "C0C0C0",
    gray: "808080",
    black: "000000",
    red: "FF0000",
    maroon: "800000",
    yellow: "FFFF00",
    olive: "808000",
    lime: "00FF00",
    green: "008000",
    aqua: "00FFFF",
    teal: "008080",
    blue: "0000FF",
    navy: "000080",
    fuchsia: "FF00FF",
    purple: "800080",
    orange: "FFA500",
  }.freeze

  DAY_OF_WEEK = %w[Sun Mon Tue Wed Thu Fri Sat].freeze
  DEFAULT_PDF_NAME = "calendar.pdf".freeze

  DEFAULT_CONFIG_FILE = "mcalendar.yml".freeze
  GLOBAL_CONFIG_FILE = File.expand_path("~/.mcalendar.yml").freeze
  BUILT_IN_CONFIG_FILE = File.expand_path("../../mcalendar.yml", __dir__).freeze
end
