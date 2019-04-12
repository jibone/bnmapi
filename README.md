# Bnmapi

[![Maintainability](https://api.codeclimate.com/v1/badges/b6e071e2dc07ea011a62/maintainability)](https://codeclimate.com/github/jibone/bnmapi/maintainability)
[![Test
Coverage](https://api.codeclimate.com/v1/badges/b6e071e2dc07ea011a62/test_coverage)](https://codeclimate.com/github/jibone/bnmapi/test_coverage)i

Ruby wrapper for Bank Negara Malaysia Open API. Details and API disclaimer can
be found here [BNM Open API](https://api.bnm.gov.my/portal)

_Note:_ This gem is still in early devvelopment stages and not ready for use.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bnmapi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bnmapi

## Usage

### Getting Started

#### (/welcome)
https://api.bnm.gov.my/portal#operation/Welcome

Getting started API which returns information and descriptions for BNM Open APi.

```ruby
welcome = BnmAPI::Welcome.get

puts welcome.name
# BNM.API

puts welcome.api
# ['v1']

puts welcome.description
# displays API discription

puts welcome.disclaimer
# https://api.bnm.gov.my/disclaimer

puts welcome.contact_name
# BNM.API

puts welcome.contact_email
# oapi@bnm.gov.my
```

### Base Rate/BLR/Effective LR

Current Base Rates and Base Lending Rates for retail loans or financing
facilities and Indicative Effective Lending Rates for a standard housing
loan/home financing offered by financial institutions.

#### (latest)
https://api.bnm.gov.my/portal#operation/BRLatest

Creates a list of bank information with base rate and base lending rates
details.

```ruby
collection = BnmAPI::BaseRate.latest

collection.size
# 35 (number if bank in the response like)

puts collection[0].bank_code
# BKKBMYKL

puts collection[0].bank_name
# Bangkok Bank Berhad

puts collection[0].base_rate
# 4.72

puts collection[0].base_financing_rate
# 7.37

puts collection[0].base_lending_rate
# 5.92

puts collection[0].last_updated.class
# DateTime

puts collection[0].last_updated.iso8601
# 2019-01-18T19:25:02+00:00

puts collection[0].effective_date.class
# Date

puts collection[0].effective_date.iso8601
# 2019-04-05
```

#### (by bank code)
https://api.bnm.gov.my/portal#operation/BRBankCode

```ruby
bank = BnmAPI::BaseRate.by_bank_code('BKKBMYKL')

puts bank.bank_code
# BKKBMYKL

puts bank.bank_name
# Bangkok Bank Berhad

puts bank.base_rate
# 4.72

puts bank.base_lending_rate
# 7.37

puts bank.indicative_eff_lending_rate
# 5.92

puts bank.last_updated.class
# DateTime

puts bank.last_updated.iso8601
# 2019-01-18T19:25:02+00:00

puts bank.effective_date.class
# Date

puts bank.effective_date.iso8601
# 2019-04-05
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run
`rake spec` to run the tests. You can also run `bin/console` for an interactive
prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To 
release a new version, update the version number in `version.rb`, and then run 
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jibone/bnmapi. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere to
the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the
[MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Bnmapi project’s codebases, issue trackers,
chat rooms and mailing lists is expected to follow the
[code of conduct](https://github.com/jibone/bnmapi/blob/master/CODE_OF_CONDUCT.md).
