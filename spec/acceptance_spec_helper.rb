require_relative 'support/tests/current_bundle'

Tests::CurrentBundle.instance.assert_appraisal!

#---

require 'rspec/core'

require 'spec_helper'

acceptance_test_files =
  Pathname.new('../support/acceptance/**/*.rb').expand_path(__FILE__)

Dir.glob(acceptance_test_files).sort.each { |file| require file }

RSpec.configure do |config|
  AcceptanceTests::Helpers.configure_example_group(config)
  config.include(AcceptanceTests::Matchers)
end
