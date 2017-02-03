# Shoulda [![Gem Version][version-badge]][rubygems] [![Build Status][travis-badge]][travis] ![Downloads][downloads-badge]

[version-badge]: https://badge.fury.io/rb/shoulda.png
[rubygems]: http://rubygems.org/gems/shoulda
[travis-badge]: https://secure.travis-ci.org/thoughtbot/shoulda.png
[travis]: http://travis-ci.org/thoughtbot/shoulda
[downloads-badge]: http://img.shields.io/gem/dtv/shoulda.svg

Shoulda is for writing better Rails-specific tests using Minitest.

The `shoulda` gem doesn't contain any code of its own; it actually brings
behavior from two other gems:

* [Shoulda Context]
* [Shoulda Matchers]

See the READMEs for these projects for more information.

[Shoulda Context]: https://github.com/thoughtbot/shoulda-context
[Shoulda Matchers]: https://github.com/thoughtbot/shoulda-matchers

## Usage

```ruby
class UserTest < ActiveSupport::TestCase
  should have_many(:posts)
  should_not allow_value("blah").for(:email)
end
```

Here, the `should` keyword comes from Shoulda Context; matchers (e.g.
`have_many`, `allow_value`) come from Shoulda Matchers.

Credits
-------

[<img src="http://presskit.thoughtbot.com/images/signature.svg" width="250" alt="thoughtbot logo">][thoughtbot, inc]

Shoulda is maintained by [thoughtbot, inc]. It is funded by thoughtbot, inc.,
and the names and logos for thoughtbot are trademarks of thoughtbot, inc.

Thank you to all of the [contributors]!

[contributors]: https://github.com/thoughtbot/shoulda/contributors

License
-------

Shoulda is copyright © 2006-2017 [thoughtbot, inc]. It is free software, and may
be redistributed under the terms specified in the MIT-LICENSE file.

[thoughtbot, inc]: http://thoughtbot.com/community
