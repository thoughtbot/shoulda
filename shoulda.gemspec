$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'shoulda/version'

Gem::Specification.new do |s|
  s.name = 'shoulda'
  s.version = Shoulda::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = [
    'Tammer Saleh',
    'Joe Ferris',
    'Ryan McGeary',
    'Dan Croak',
    'Matt Jankowski',
  ]
  s.email = 'support@thoughtbot.com'
  s.homepage = 'https://github.com/thoughtbot/shoulda'
  s.summary = 'Making tests easy on the fingers and eyes'
  s.description = 'Making tests easy on the fingers and eyes'
  s.license = 'MIT'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map do |file|
    File.basename(file)
  end
  s.require_paths = ['lib']

  s.add_dependency('shoulda-context', '~> 2.0')
  s.add_dependency('shoulda-matchers', '~> 4.0')
end
