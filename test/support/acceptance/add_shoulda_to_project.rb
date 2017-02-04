require_relative 'helpers/base_helpers'
require_relative 'helpers/gem_helpers'

module AcceptanceTests
  class AddShouldaToProject
    def self.call(options)
      new(options).call
    end

    include BaseHelpers
    include GemHelpers

    def initialize(options)
      @options = options
    end

    def call
      add_gem 'shoulda', gem_options

      unless options[:with_configuration] === false
        add_configuration_block_to_test_helper
      end
    end

    protected

    attr_reader :options

    private

    def test_framework
      options[:test_framework]
    end

    def libraries
      options.fetch(:libraries, [])
    end

    def gem_options
      gem_options = { path: fs.root_directory }

      if options[:manually]
        gem_options[:require] = false
      end

      gem_options
    end

    def add_configuration_block_to_test_helper
      content = <<-EOT
        Shoulda::Matchers.configure do |config|
          config.integrate do |with|
            #{test_framework_config}
            #{library_config}
          end
        end
      EOT

      if options[:manually]
        content = "require 'shoulda'\n#{content}"
      end

      fs.append_to_file('test/test_helper.rb', content)
    end

    def test_framework_config
      if test_framework
        "with.test_framework :#{test_framework}\n"
      else
        ''
      end
    end

    def library_config
      libraries.map { |library| "with.library :#{library}" }.join("\n")
    end
  end
end
