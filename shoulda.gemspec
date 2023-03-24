$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
require 'shoulda/version'

Gem::Specification.new do |s|
  s.name        = 'shoulda'
  s.version     = Shoulda::VERSION.dup
  s.authors     = [
    'Tammer Saleh',
    'Joe Ferris',
    'Ryan McGeary',
    'Dan Croak',
    'Matt Jankowski',
  ]
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.email       = 'support@thoughtbot.com'
  s.homepage    = 'https://github.com/thoughtbot/shoulda'
  s.summary     = 'Making tests easy on the fingers and eyes'
  s.license = 'MIT'
  s.description = 'Making tests easy on the fingers and eyes'

  s.metadata = {
    'bug_tracker_uri' => 'https://github.com/thoughtbot/shoulda/issues',
    'changelog_uri' => 'https://github.com/thoughtbot/shoulda/blob/main/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/thoughtbot/shoulda',
  }

  s.files = Dir['lib/**/*', 'README.md', 'LICENSE', 'shoulda.gemspec']
  s.require_paths = ['lib']

  s.required_ruby_version = '>= 3.0.5'
  s.add_dependency('shoulda-context', '~> 2.0')
  s.add_dependency('shoulda-matchers', '~> 5.0')
end
