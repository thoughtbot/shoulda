namespace :shoulda do
  desc "List the names of the test methods in a specification like format"
  task :list do
    $LOAD_PATH.unshift("test")

    require 'test/unit'
    require 'rubygems'
    require 'active_support'

    # bug in test unit.  Set to true to stop from running.
    Test::Unit.run = true

    test_files = Dir.glob(File.join('test', '**', '*_test.rb'))
    test_files.each do |file|
      klass_name = file.split('/')[2..-1].tap do |paths| # strip test/(unit|functional|integration)
        paths.shift if paths.first == "helpers"
      end.join('/')[0..-4].classify # strip .rb

      puts klass_name.gsub('Test', '')

      load file

      klass = klass_name.to_s.split("::").flatten.inject("Object") do |parent,child|
        case parent
        when nil then nil
        else parent.constantize.const_defined?(child) ? "#{parent}::#{child}" : nil
        end
      end

      unless klass
        puts "Skipping #{klass_name} because it doesn't map to a Class"
        next
      end

      klass = klass.constantize
      test_methods = klass.instance_methods.grep(/^test/).map {|s| s.gsub(/^test: /, '')}.sort
      test_methods.each {|m| puts "  " + m }
    end
  end
end
