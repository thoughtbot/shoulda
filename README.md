# shoulda [![Gem Version](https://badge.fury.io/rb/shoulda.png)](http://badge.fury.io/rb/shoulda) [![Build Status](https://secure.travis-ci.org/thoughtbot/shoulda.png)](http://travis-ci.org/thoughtbot/shoulda)

The shoulda gem is a meta gem with two dependencies:

* [shoulda-context](https://github.com/thoughtbot/shoulda-context) ([official documentation](http://rubydoc.info/github/thoughtbot/shoulda-context/master/frames))
* [shoulda-matchers](https://github.com/thoughtbot/shoulda-matchers) ([official documentation](http://rubydoc.info/github/thoughtbot/shoulda-matchers/master/frames))

The following describes different use cases and combinations.

rspec with shoulda-matchers
---------------------------

This is what thoughtbot currently does. We write tests like:

```ruby
describe Post do
  it { should belong_to(:user) }
  it { should validate_presence_of(:title) }
end
```

The belong_to and validate_presence_of methods are the matchers.
All matchers are Rails 3-specific.

Add rspec-rails and shoulda-matchers to the project's Gemfile:

```ruby
group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
end
```

test/unit with shoulda
----------------------

For the folks who prefer Test::Unit, they'd write tests like:

```ruby
class UserTest < Test::Unit::TestCase
  should have_many(:posts)
  should_not allow_value("blah").for(:email)
end
```

The have_many and allow_value methods are the same kind of matchers
seen in the RSpec example. They come from the shoulda-matchers gem.

Add shoulda to the project's Gemfile:

```ruby
group :test do
  gem 'shoulda'
end
```

test/unit with shoulda-context
------------------------------

If you're not testing a Rails project or don't want to use the matchers,
you can use shoulda-context independently to write tests like:

```ruby
class CalculatorTest < Test::Unit::TestCase
  context "a calculator" do
    setup do
      @calculator = Calculator.new
    end

    should "add two numbers for the sum" do
      assert_equal 4, @calculator.sum(2, 2)
    end

    should "multiply two numbers for the product" do
      assert_equal 10, @calculator.product(2, 5)
    end
  end
end
```

Add shoulda-context to the project's Gemfile:

```ruby
group :test do
  gem 'shoulda-context'
end
```

Credits
-------

![thoughtbot](http://thoughtbot.com/assets/tm/logo.png)

Shoulda is maintained and funded by [thoughtbot, inc](http://thoughtbot.com/community)

Thank you to all [the contributors](https://github.com/thoughtbot/shoulda/contributors)!

The names and logos for thoughtbot are trademarks of thoughtbot, inc.

License
-------

Shoulda is Copyright © 2006-2013 Tammer Saleh and thoughtbot, inc. It is free software, and may be redistributed under the terms specified in the MIT-LICENSE file.
