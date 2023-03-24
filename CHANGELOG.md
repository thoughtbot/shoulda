# Changelog

## 5.0.0.rc1 - 2023-03-23

* `shoulda` now relies upon `shoulda-matchers` 5.x. You can find changes to
  `shoulda-matchers` in its [changelog][shoulda-matchers-5-3-0-changelog].
* Support for Ruby < 3 and Rails < 6.1 have been dropped due to being EOL.
* Support for Ruby 3.0, 3.1, and 3.2 as well as Rails 6.1 and 7.0 have been
  added.

[shoulda-matchers-5-3-0-changelog]: https://github.com/thoughtbot/shoulda-matchers/blob/v5.3.0/CHANGELOG.md

## 4.0.0 - 2020-06-13

* `shoulda` now brings in `shoulda-context` 2.0.0, which adds compatibility for
  Ruby 2.7, Rails 6.0, and shoulda-matchers 4.0! Note that there are some
  backward incompatible changes, so please see the [changelog
  entry][shoulda-context-2-0-0] for this release to learn more.

[shoulda-context-2-0-0]: https://github.com/thoughtbot/shoulda-context/blob/master/CHANGELOG.md#200-2020-06-13
