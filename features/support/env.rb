require 'aruba/cucumber'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..', '..')).freeze
APP_NAME     = 'testapp'.freeze

Before do
  @aruba_timeout_seconds = 15

  if ENV['DEBUG']
    @puts = true
    @announce_stdout = true
    @announce_stderr = true
    @announce_cmd = true
    @announce_dir = true
    @announce_env = true
  end
end

module AppendHelpers
  def append_to(path, contents)
    cd('.') do
      File.open(path, "a") do |file|
        file.puts
        file.puts contents
      end
    end
  end

  def append_to_gemfile(contents)
    append_to('Gemfile', contents)
  end
end

module RailsHelpers
  def rails_version
    Gem::Version.new(Bundler.definition.specs['rails'][0].version)
  end
end

World(AppendHelpers)
World(RailsHelpers)
