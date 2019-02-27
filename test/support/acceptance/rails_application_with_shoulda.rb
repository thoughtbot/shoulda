require_relative 'add_shoulda_to_project'
require_relative '../snowglobe'

module AcceptanceTests
  class RailsApplicationWithShoulda < Snowglobe::RailsApplication
    def create
      super

      bundle.updating do
        bundle.add_gem 'minitest-reporters'
        AddShouldaToProject.call(
          self,
          test_framework: :minitest,
          libraries: [:rails],
        )
      end

      fs.append_to_file 'test/test_helper.rb', <<-FILE
        require 'minitest/autorun'
        require 'minitest/reporters'

        Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

        begin
          require "rails/test_unit/reporter"

          # Patch Rails' reporter for Minitest so that it looks for the test
          # correctly under Minitest 5.11
          # See: <https://github.com/rails/rails/pull/31624>
          Rails::TestUnitReporter.class_eval do
            def format_rerun_snippet(result)
              location, line = if result.respond_to?(:source_location)
                result.source_location
              else
                result.method(result.name).source_location
              end

              "\#{executable} \#{relative_path_for(location)}:\#{line}"
            end
          end
        rescue LoadError
          # Okay, rails/test_unit/reporter isn't a thing, no big deal
        end
      FILE
    end
  end
end
