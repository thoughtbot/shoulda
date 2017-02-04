require_relative 'file_helpers'
require_relative 'gem_helpers'

module AcceptanceTests
  module StepHelpers
    include FileHelpers
    include GemHelpers

    def add_shoulda_to_project(options = {})
      AddShouldaToProject.call(options)
    end

    def add_minitest_to_project
      add_gem 'minitest-reporters'

      append_to_file 'test/test_helper.rb', <<-FILE
        require 'minitest/autorun'
        require 'minitest/reporters'

        Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
      FILE
    end

    def run_n_unit_tests(*paths)
      run_command_within_bundle 'ruby -I lib -I test', *paths
    end

    def run_n_unit_test_suite
      run_rake_tasks('test', env: { TESTOPTS: '-v' })
    end

    def create_rails_application
      fs.clean
      rails_new
      remove_unnecessary_gems
      add_minitest_reporters_to_test_helper
    end

    private

    def rails_new
      command = "bundle exec rails new #{fs.project_directory} --skip-bundle --no-rc"

      run_command!(command) do |runner|
        runner.directory = nil
      end

      command
    end

    def remove_unnecessary_gems
      updating_bundle do |bundle|
        bundle.remove_gem 'turn'
        bundle.remove_gem 'coffee-rails'
        bundle.remove_gem 'uglifier'
        bundle.remove_gem 'debugger'
        bundle.remove_gem 'byebug'
        bundle.remove_gem 'web-console'
      end
    end

    def add_minitest_reporters_to_test_helper
      fs.append_to_file 'test/test_helper.rb', <<-TEXT
require 'minitest/reporters'
Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)
      TEXT
    end
  end
end
