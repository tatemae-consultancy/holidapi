# HolidApi

HolidApi is a Ruby gem that provides a wrapper for interacting with the [Holiday APi service](http://holidayapi.com).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'holidapi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install holidapi

## Usage

    require 'holidapi'

    holidays = HolidApi.get

The following options can also be used

    holidays = HolidApi.get(country: 'gb', year: 2016, month: 1, day: 15)

The gem defaults to `US` for the country, and the current year

## Contributing

1. Fork it ( https://github.com/[my-github-username]/holidapi/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
