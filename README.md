# Shoulda [![Gem Version][version-badge]][rubygems] [![Build Status][travis-badge]][travis] ![Downloads][downloads-badge]

[version-badge]: http://img.shields.io/gem/v/shoulda.svg
[rubygems]: http://rubygems.org/gems/shoulda
[travis-badge]: http://img.shields.io/travis/thoughtbot/shoulda/master.svg
[travis]: http://travis-ci.org/thoughtbot/shoulda
[downloads-badge]: http://img.shields.io/gem/dtv/shoulda.svg

Shoulda helps you write more understandable, maintainable Rails-specific tests
using Minitest.

The `shoulda` gem doesn't contain any code of its own; it actually brings
behavior from two other gems:

* [Shoulda Context]
* [Shoulda Matchers]

See the READMEs for these projects for more information.

[Shoulda Context]: https://github.com/thoughtbot/shoulda-context
[Shoulda Matchers]: https://github.com/thoughtbot/shoulda-matchers

## Overview

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

## Compatibility

Shoulda is tested and supported against Ruby 2.2-2.4, Rails 4.2-5.0, and
Minitest 5.

## Contributing

Shoulda is open source, and we are grateful for [everyone][contributors] who's
contributed so far.

If you'd like to contribute, please take a look at the
[instructions](CONTRIBUTING.md) for installing dependencies and crafting a good
pull request.

[contributors]: https://github.com/thoughtbot/shoulda/contributors

## Versioning

Shoulda follows Semantic Versioning 2.0 as defined at <http://semver.org>.

## License

Shoulda is copyright © 2006-2017 [thoughtbot, inc][thoughtbot]. It is free
software, and may be redistributed under the terms specified in the
[MIT-LICENSE](MIT-LICENSE) file.

## About thoughtbot

[<img src="http://presskit.thoughtbot.com/images/signature.svg" width="250" alt="thoughtbot logo">][thoughtbot]

Shoulda is maintained and funded by thoughtbot, inc. The names and logos for
thoughtbot are trademarks of thoughtbot, inc.

We are passionate about open source software. See [our other
projects][community]. We are [available for hire][thoughtbot].

[community]: https://thoughtbot.com/community?utm_source=github
[thoughtbot]: https://thoughtbot.com?utm_source=github
