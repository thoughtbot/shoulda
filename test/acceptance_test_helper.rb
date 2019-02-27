require_relative 'support/current_bundle'

Tests::CurrentBundle.instance.assert_appraisal!

#---

require 'test_helper'

require_relative 'support/acceptance/rails_application_with_shoulda'
require_relative 'support/acceptance/matchers/have_output'
require_relative 'support/acceptance/matchers/indicate_that_tests_were_run'

class AcceptanceTest < Minitest::Test
  include AcceptanceTests::Matchers

  private

  def app
    @app ||= AcceptanceTests::RailsApplicationWithShoulda.new
  end
end

begin
  require 'rails/test_unit/reporter'

  # Patch Rails' reporter for Minitest so that it looks for the test
  # correctly under Minitest 5.11
  # See: <https://github.com/rails/rails/pull/31624>
  Rails::TestUnitReporter.class_eval do
    def format_rerun_snippet(result)
      location, line =
        if result.respond_to?(:source_location)
          result.source_location
        else
          result.method(result.name).source_location
        end

      "#{executable} #{relative_path_for(location)}:#{line}"
    end
  end
rescue LoadError
  # Okay, rails/test_unit/reporter isn't a thing, no big deal
end
