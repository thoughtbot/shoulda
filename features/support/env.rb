require 'aruba/cucumber'

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
