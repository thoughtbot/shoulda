# Note: All of the dependencies here were obtained by running `rails new` with
# various versions of Rails and copying lines from the generated Gemfile. It's
# best to keep the gems here in the same order as they're listed there so you
# can compare them more easily.

shared_rails_dependencies = proc do
  gem 'sqlite3', '~> 1.3.6'
  gem 'rubyzip', '~> 1.3.0'
end

shared_spring_dependencies = proc do
  gem 'spring'
  gem 'spring-commands-rspec'
end

shared_test_dependencies = proc do
  gem 'minitest-reporters'
end

shared_dependencies = proc do
  instance_eval(&shared_rails_dependencies)
  instance_eval(&shared_spring_dependencies)
  instance_eval(&shared_test_dependencies)
end

appraise 'rails_4_2' do
  instance_eval(&shared_dependencies)

  gem 'rails', '~> 4.2.10'
  gem 'sass-rails', '~> 5.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.1.0'
  gem 'jquery-rails'
  gem 'turbolinks'
  gem 'jbuilder', '~> 2.0'
  gem 'sdoc', '~> 0.4.0', group: :doc
  gem 'bcrypt', '~> 3.1.7'

  # Other dependencies we use
  gem 'activeresource', '4.0.0'
  gem 'json', '~> 1.4'
  gem 'protected_attributes', '~> 1.0.6'
end

appraise 'rails_5_0' do
  instance_eval(&shared_dependencies)

  gem 'rails', '~> 5.0.7'
  gem 'rails-controller-testing', '>= 1.0.1'
  gem 'puma', '~> 3.0'
  gem 'sass-rails', '~> 5.0'
  gem 'jquery-rails'
  gem 'turbolinks', '~> 5'
  gem 'jbuilder', '~> 2.5'
  gem 'bcrypt', '~> 3.1.7'
  gem 'listen', '~> 3.0.5'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

appraise 'rails_5_1' do
  instance_eval(&shared_dependencies)
  gem 'rails', '~> 5.1.6'
  gem 'rails-controller-testing', '>= 1.0.1'
  gem 'puma', '~> 3.7'
  gem 'sass-rails', '~> 5.0'
  gem 'turbolinks', '~> 5'
  gem 'jbuilder', '~> 2.5'
  gem 'bcrypt', '~> 3.1.7'
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

appraise 'rails_5_2' do
  instance_eval(&shared_dependencies)

  gem 'rails', '~> 5.2.2'
  gem 'rails-controller-testing', '>= 1.0.1'
  gem 'puma', '~> 3.11'
  gem 'bootsnap', '>= 1.1.0', require: false
  gem 'sass-rails', '~> 5.0'
  gem 'turbolinks', '~> 5'
  gem 'jbuilder', '~> 2.5'
  gem 'bcrypt', '~> 3.1.7'
  gem 'capybara', '~> 3.1.1'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

if Gem::Requirement.new('>= 2.5.0').satisfied_by?(Gem::Version.new(RUBY_VERSION))
  appraise 'rails_6_0' do
    instance_eval(&shared_dependencies)

    gem 'rails', '~> 6.0.2'
    gem 'puma', '~> 4.1'
    gem 'sass-rails', '>= 6'
    gem 'webpacker', '~> 4.0'
    gem 'turbolinks', '~> 5'
    gem 'jbuilder', '~> 2.7'
    gem 'bcrypt', '~> 3.1.7'
    gem 'bootsnap', '>= 1.4.2', require: false
    gem 'listen', '>= 3.0.5', '< 3.2'
    gem 'spring-watcher-listen', '~> 2.0.0'
    gem 'capybara', '>= 2.15'
    gem 'selenium-webdriver'
    gem "sqlite3", "~> 1.4.0"
    gem 'webdrivers'

    # Other dependencies
    gem 'rails-controller-testing', '>= 1.0.4'
    gem 'pg', '~> 1.1', platform: :ruby
  end
end
