# Maintaining Shoulda

Although Shoulda doesn't receive feature updates these days, you may need to
update the gem for new versions of Ruby or Rails. Here's what you need to know
in order to do that.

## Getting started

First, run the setup script:

    bin/setup

Then run all the tests to make sure everything is green:

    bundle exec rake

## Running tests

This project uses Minitest for tests and Appraisal to create environments
attuned for different versions of Rails. To run a single test in a single test
file, you will need to use a combination of Appraisal and the [`m`][m] gem. For
instance:

[m]: https://github.com/qrush/m

    bundle exec appraisal rails_6_0 m test/acceptance/integrates_with_rails_test.rb:9

## Updating the changelog

After every user-facing change makes it into master, we make a note of it in the
changelog, kept in `CHANGELOG.md`. The changelog is sorted in reverse order by
release version, with the topmost version as the next release (tagged as
"(Unreleased)").

Within each version, there are five available categories you can divide changes
into. They are all optional but they should appear in this order:

1. Backward-compatible changes
1. Deprecations
1. Bug fixes
1. Features
1. Improvements

Within each category section, the changes relevant to that category are listed
in chronological order.

For each change, provide a human-readable description of the change as well as a
linked reference to the PR where that change emerged (or the commit ID if no
such PR is available). This helps users cross-reference changes if they need to.

## Versioning

### Naming a new version

As designated in the README, we follow [SemVer 2.0][semver]. This offers a
meaningful baseline for deciding how to name versions. Generally speaking:

[semver]: https://semver.org/spec/v2.0.0.html

* We bump the "major" part of the version if we're introducing
  backward-incompatible changes (e.g. changing the API or core behavior,
  removing parts of the API, or dropping support for a version of Ruby).
* We bump the "minor" part if we're adding a new feature (e.g. adding a new
  matcher or adding a new qualifier to a matcher).
* We bump the "patch" part if we're merely including bugfixes.

In addition to major, minor, and patch levels, you can also append a
suffix to the version for pre-release versions. We usually use this to issue
release candidates prior to an actual release. A version number in this case
might look like `4.0.0.rc1`.

### Preparing and releasing a new version

In order to release any versions at all, you will need to have been added as
an owner of the Ruby gem. If you want to give someone else these permissions,
then run:

```bash
gem owner shoulda -a <email address>
```

Assuming you have permission to publish a new version to RubyGems, then this is
how you release a version:

1. First, you'll want to [make sure that the changelog is up to
   date](#updating-the-changelog).

2. Next, you'll want to update the `VERSION` constant in
   `lib/shoulda/version.rb`. This constant is referenced in the gemspec and is
   used in the Rake tasks to publish the gem on RubyGems.

3. Assuming that everything looks good, place your changes to the changelog,
   `version.rb`, and README in their own commit titled "Bump version to
   *X.Y.Z*". Push this to GitHub (you can use `[ci skip]`) in the body of the
   commit message to skip CI for this commit if you so choose). **There is no
   going back after this point!**

6. Once GitHub has the version-change commit, you will run:

   ```bash
   rake release
   ```

   This will push the gem to RubyGems and make it available for download.
