require 'snowglobe'

Snowglobe.configure do |config|
  config.project_name = 'shoulda_test'
  config.temporary_directory = Pathname.new('../../tmp').expand_path(__dir__)
end

Snowglobe::Project.class_eval do
  # Snowglobe is missing a delegator for run_n_unit_test_suite, so add it in
  def_delegators :command_runner, :run_n_unit_test_suite
end

Snowglobe::CommandRunner.class_eval do
  # Patch a bug in Snowglobe where ProjectCommandRunner tries to access `env`
  # from a CommandRunner instance, but it is private
  attr_reader :env
end

Snowglobe::RailsApplication.class_eval do
  def run_migrations!
    command_runner.run_rake_tasks!([
                                     'db:environment:set RAILS_ENV=test',
                                     'db:drop',
                                     'db:create',
                                     'db:migrate',
                                   ])
  end

  private

  # In recent versions of Rails, config/boot.rb uses double quotes instead of
  # single quotes, so patch Snowglobe to work either way
  def remove_bootsnap
    fs.comment_lines_matching_in_file(
      'config/boot.rb',
      %r{\Arequire (['"])bootsnap/setup\1},
    )
  end
end
