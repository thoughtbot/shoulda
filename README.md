# Shoulda [![Gem Version][version-badge]][rubygems] [![Build Status][github-actions-badge]][github-actions] [![Total Downloads][downloads-total]][rubygems] [![Downloads][downloads-badge]][rubygems]

[version-badge]: https://img.shields.io/gem/v/shoulda.svg
[rubygems]: https://rubygems.org/gems/shoulda
[github-actions-badge]: https://img.shields.io/github/actions/workflow/status/thoughtbot/shoulda/ci.yml?branch=main
[github-actions]: https://github.com/thoughtbot/shoulda/actions
[downloads-total]: https://img.shields.io/gem/dt/shoulda.svg
[downloads-badge]: https://img.shields.io/gem/dtv/shoulda.svg
[downloads-badge]: https://img.shields.io/gem/dtv/shoulda.svg

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

Shoulda is tested and supported against Ruby 3.0+, Rails 6.1+, RSpec 3.x,
Minitest 4.x, and Test::Unit 3.x.

- For Ruby < 3 and Rails < 6.1 compatibility, please use [v4.0.0][v4.0.0].

[v4.0.0]: https://github.com/thoughtbot/shoulda-matchers/tree/v4.0.0

## Versioning

Shoulda follows Semantic Versioning 2.0 as defined at <http://semver.org>.

## Team

Shoulda is currently maintained by [Pedro Paiva][VSPPedro]. Previous maintainers
include [Elliot Winkler][mcmire], [Jason Draper][drapergeek], [Gabe
Berke-Williams][gabebw], [Ryan McGeary][rmm5t], [Joe Ferris][jferris], [Dan
Croaky][croaky], and [Tammer Saleh][tammersaleh].

[VSPPedro]: https://github.com/VSPPedro
[mcmire]: https://github.com/mcmire
[drapergeek]: https://github.com/drapergeek
[gabebw]: https://github.com/gabebw
[rmm5t]: https://github.com/rmm5t
[jferris]: https://github.com/jferris
[croaky]: https://github.com/croaky
[tammersaleh]: https://github.com/tammersaleh

## Copyright/License

Shoulda is copyright © Tammer Saleh and [thoughtbot,
inc][thoughtbot-website]. It is free and opensource software and may be
redistributed under the terms specified in the [LICENSE](LICENSE) file.

[thoughtbot-website]: https://thoughtbot.com

<!-- START /templates/footer.md -->
<!-- END /templates/footer.md -->
