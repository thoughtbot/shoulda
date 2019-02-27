require 'bundler/setup'
require 'pry'
require 'pry-byebug'
require 'minitest/autorun'
require 'minitest/reporters'
require 'warnings_logger'

require_relative '../lib/shoulda'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

WarningsLogger::Spy.call(
  project_name: 'shoulda',
  project_directory: Pathname.new('../..').expand_path(__FILE__),
)

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
  end
end

$VERBOSE = true
