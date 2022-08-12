
# Mcalendar [![Gem Version](https://badge.fury.io/rb/mcalendar.svg)](https://badge.fury.io/rb/mcalendar)

Ruby monthly calendar, output to console and pdf.  
This calendar includes Japanese holidays.

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
Output to console and pdf.
```
      September 2021
Sun Mon Tue Wed Thu Fri Sat
             1   2   3   4
 5   6   7   8   9  10  11
12  13  14  15  16  17  18
19  20  21  22  23  24  25
26  27  28  29  30
```


Calendar for any month.
```
mcalendar 2021/02
```
Output to console and pdf.
```
>mcalendar 2021/02
       February 2021
Sun Mon Tue Wed Thu Fri Sat
     1   2   3   4   5   6
 7   8   9  10  11  12  13
14  15  16  17  18  19  20
21  22  23  24  25  26  27
28
```

Output only PDF, use the `-p` option.
```
mcalendar 2021/02 -p
```

Also, If you want to output only console, use the `-c` option.
```
mcalendar 2021/02 -c
```

The default PDF file name is `calendar.pdf`. You can specify any name using the `-n` option.
```
mcalendar 2021/02 -n my_calendar.pdf
```

### Configure mcalendar schedule

mcalendar reads `~/.mcalendar.yml` or `mcalendar.yml` in the current working directory as mcalendar's schedule file. It can contain the following settings:
* holiday
* anniversary

Here is the included mcalendar.yml as a sample.

`mcalendar.yml`
```
holiday:
  20210101: New Year's Day
  20210111: Coming-of-age Day
  20210211: National Foundation Day
  20210223: Emperor's Birthday
  20210320: Vernal Equinox Day
  20210429: Showa Day
  20210503: Constitution Memorial Day
  20210504: Greenery Day
  20210505: Children's Day
  20210722: Marine Day
  20210723: Sports Day
  20210808: Mountain Day
  20210809: Substitute Holiday
  20210920: Respect for the Aged Day
  20210923: Autumnal Equinox Day
  20211103: Culture Day
  20211123: Labour Thanksgiving Day

anniversary:
  20210224: Ruby's Birthday
  20210909: RubyKaigi Takeout 2021
  20210910: RubyKaigi Takeout 2021
  20210911: RubyKaigi Takeout 2021
```

You can use the command option `-y` or `--holidays` to check the contents of mcalendar.yml.

```
>mcalendar --holidays
=========== Holidays ===========
20210101: New Year's Day
20210111: Coming-of-age Day
20210211: National Foundation Day
20210223: Emperor's Birthday
20210320: Vernal Equinox Day
20210429: Showa Day
20210503: Constitution Memorial Day
20210504: Greenery Day
20210505: Children's Day
20210722: Marine Day
20210723: Sports Day
20210808: Mountain Day
20210809: Substitute Holiday
20210920: Respect for the Aged Day
20210923: Autumnal Equinox Day
20211103: Culture Day
20211123: Labour Thanksgiving Day
======== Anniversaries =========
20210224: Ruby's Birthday
20210909: RubyKaigi Takeout 2021
20210910: RubyKaigi Takeout 2021
20210911: RubyKaigi Takeout 2021
```

You can also use the command option `-f` or `--config=` to load your own `your_schedule.yml` file.
```
>mcalendar -f your_schedule.yml
```

How many Sundays are there this month? 
Use the command option `-w`, You can easily know this answer.
```
>mcalendar -w

Number of days for each day of the week in August 2022
-----------------------------------------------------------------------
Sun. 4 days. =>  7,14,21,28
Mon. 5 days. =>  1, 8,15,22,29
Tue. 5 days. =>  2, 9,16,23,30
Wed. 5 days. =>  3,10,17,24,31
Thu. 4 days. =>  4,11,18,25
Fri. 4 days. =>  5,12,19,26
Sat. 4 days. =>  6,13,20,27
```


Show help
```
>mcalendar --help
Usage: mcalendar [options]
    -v, --version                    Show version
    -p, --pdf                        output pdf
    -n, --name=NAME                  output pdf name
    -c, --console                    output console
    -f, --config=FILE                Use YAML format file.
    -y, --holidays                   Display holidays and anniversaries in YAML file
    -w, --wday                       Number of days for each day of the week in this month
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
