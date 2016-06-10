require 'bundler/setup'
require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'appraisal'

def appraisal_in_use?
  Bundler.default_gemfile.dirname ==
    Pathname.new('../gemfiles').expand_path(__FILE__)
end

Cucumber::Rake::Task.new do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

desc 'Test the plugin under all supported Rails versions.'
task :all do
  if appraisal_in_use?
    exec 'bundle exec rake cucumber --trace'
  else
    exec 'bundle exec appraisal install && appraisal rake --trace'
  end
end

desc 'Default: run cucumber features'
task :default => [:all]
