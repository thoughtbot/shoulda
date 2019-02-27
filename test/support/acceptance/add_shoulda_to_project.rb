module AcceptanceTests
  class AddShouldaToProject
    ROOT_DIRECTORY = Pathname.new('../../..').expand_path(__FILE__)

    def self.call(app, options)
      new(app, options).call
    end

    def initialize(app, options)
      @app = app
      @options = options
    end

    def call
      app.add_gem 'shoulda', gem_options

      unless options[:with_configuration] === false
        add_configuration_block_to_test_helper
      end
    end

    private

    attr_reader :app, :options

    def test_framework
      options[:test_framework]
    end

    def libraries
      options.fetch(:libraries, [])
    end

    def gem_options
      gem_options = { path: ROOT_DIRECTORY }

      if options[:manually]
        gem_options[:require] = false
      end

      gem_options
    end

    def add_configuration_block_to_test_helper
      content = <<-CONTENT
        Shoulda::Matchers.configure do |config|
          config.integrate do |with|
            #{test_framework_config}
            #{library_config}
          end
        end
      CONTENT

      if options[:manually]
        content = "require 'shoulda'\n#{content}"
      end

      app.append_to_file('test/test_helper.rb', content)
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
