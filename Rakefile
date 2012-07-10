require 'bundler/setup'
require 'bundler/gem_tasks'
require 'cucumber/rake/task'
require 'appraisal'

Cucumber::Rake::Task.new do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

desc 'Test the plugin under all supported Rails versions.'
task :all => ["appraisal:cleanup", "appraisal:install"] do
  exec('rake appraisal cucumber')
end

desc 'Default: run cucumber features'
task :default => [:all]
