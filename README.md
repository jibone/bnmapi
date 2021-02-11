# Bnmapi

[![Maintainability](https://api.codeclimate.com/v1/badges/b6e071e2dc07ea011a62/maintainability)](https://codeclimate.com/github/jibone/bnmapi/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/b6e071e2dc07ea011a62/test_coverage)](https://codeclimate.com/github/jibone/bnmapi/test_coverage)

Ruby wrapper for Bank Negara Malaysia Open API. Details and API disclaimer can
be found here [BNM Open API](https://api.bnm.gov.my/portal)

_Note:_ This gem is still in early development stages and not ready for use.

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

[Full documentation](https://jibone.github.io/bnmapi)

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
