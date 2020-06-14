# Shoulda [![Gem Version][version-badge]][rubygems] [![Build Status][travis-badge]][travis] ![Downloads][downloads-badge] [![Hound][hound-badge]][hound]

[version-badge]: http://img.shields.io/gem/v/shoulda.svg
[rubygems]: http://rubygems.org/gems/shoulda
[travis-badge]: http://img.shields.io/travis/thoughtbot/shoulda/master.svg
[travis]: http://travis-ci.org/thoughtbot/shoulda
[downloads-badge]: http://img.shields.io/gem/dtv/shoulda.svg
[hound-badge]: https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg
[hound]: https://houndci.com

Shoulda helps you write more understandable, maintainable Rails-specific tests
under Minitest and Test::Unit.

## Quick links

📢 **[See what's changed in recent versions.][changelog]**

[changelog]: CHANGELOG.md

## Overview

As an umbrella gem, the `shoulda` gem doesn't contain any code of its own but
rather brings in behavior from two other gems:

* [Shoulda Context]
* [Shoulda Matchers]

[Shoulda Context]: https://github.com/thoughtbot/shoulda-context
[Shoulda Matchers]: https://github.com/thoughtbot/shoulda-matchers

For instance:

```ruby
require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:posts)
  end

  context "validations" do
    should validate_presence_of(:email)
    should allow_value("user@example.com").for(:email)
    should_not allow_value("not-an-email").for(:email)
  end

  context "#name" do
    should "consist of first and last name" do
      user = User.new(first_name: "John", last_name: "Smith")
      assert_equal "John Smith", user.name
    end
  end
end
```

Here, the `context` and `should` methods come from Shoulda Context; matchers
(e.g. `have_many`, `allow_value`) come from Shoulda Matchers.

See the READMEs for these projects for more information.

## Compatibility

Shoulda is [tested][travis] and supported against Ruby 2.4+, Rails 4.2+, RSpec
3.x, Minitest 4.x, and Test::Unit 3.x.

## Versioning

Shoulda follows Semantic Versioning 2.0 as defined at <http://semver.org>.

## Team

Shoulda is maintained by [Elliot Winkler][mcmire]. It was previously maintained
by [Travis Jeffery][travisjeffery].

[mcmire]: https://github.com/mcmire
[travisjeffery]: https://github.com/travisjeffery

## Copyright/License

Shoulda is copyright © 2006-2020 Tammer Saleh and [thoughtbot,
inc][thoughtbot-website]. It is free and opensource software and may be
redistributed under the terms specified in the [LICENSE](LICENSE) file.

[thoughtbot-website]: https://thoughtbot.com

## About thoughtbot

![thoughtbot][thoughtbot-logo]

[thoughtbot-logo]: https://presskit.thoughtbot.com/images/thoughtbot-logo-for-readmes.svg

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We are passionate about open source software. See [our other
projects][community]. We are [available for hire][hire].

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com?utm_source=github
