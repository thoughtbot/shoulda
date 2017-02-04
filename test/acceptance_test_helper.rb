require_relative 'support/tests/current_bundle'

Tests::CurrentBundle.instance.assert_appraisal!

#---

require 'test_helper'

acceptance_test_support_files =
  Pathname.new('../support/acceptance/**/*.rb').expand_path(__FILE__)

Dir.glob(acceptance_test_support_files).sort.each { |file| require file }

class AcceptanceTest < Minitest::Test
  include AcceptanceTests::Helpers
  include AcceptanceTests::Matchers
end
