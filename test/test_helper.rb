PROJECT_ROOT = Pathname.new('../..').expand_path(__FILE__).freeze
$LOAD_PATH << File.join(PROJECT_ROOT, 'lib')

require 'pry'
require 'pry-byebug'
require 'minitest/autorun'
require 'shoulda'

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :minitest
  end
end

$VERBOSE = true
