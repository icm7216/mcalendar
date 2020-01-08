
# Mcalendar [![Gem Version](https://badge.fury.io/rb/mcalendar.svg)](https://badge.fury.io/rb/mcalendar)

Ruby monthly calendar, console and pdf.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mcalendar'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mcalendar


## Usage

If you want to create a calendar for this month.

When you run the command, the calendar appears on the console. The pdf file is created in the current directory.
```
mcalendar
```

If you want to create a calendar for any month.
```
mcalendar 2020/02
```

If you want to output only PDF, use the `-p` option.
```
mcalendar 2020/02 -p
```

Also, If you want to output only console, use the `-c` option.
```
mcalendar 2020/02 -c
```

The default PDF file name is `calendar.pdf`. You can specify any name using the `-n` option.
```
mcalendar 2020/02 -n my_calendar.pdf
```

show help
```
>mcalendar -h
Usage: mcalendar [options]
    -v, --version                    Show version
    -p, --pdf                        output pdf
    -n, --name=NAME                  output pdf name
    -c, --console                    output console
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
