When 'I generate a new Rails application' do
  steps %{
    When I run `bundle exec rails new #{APP_NAME} --skip-bundle --no-rc`
    And I cd to "#{APP_NAME}"
    And I write to "Gemfile" with:
      """
      source 'https://rubygems.org'
      gem 'rails', '#{rails_version}'
      gem 'sqlite3'
      """
    And I successfully run `bundle install --local`
  }
end

When /^I configure the application to use "([^\"]+)" from this project$/ do |name|
  append_to_gemfile "gem '#{name}', path: '#{PROJECT_ROOT}'"
  steps %{And I run `bundle install --local`}
end

When 'I configure the application to use Shoulda' do
  append_to_gemfile "gem 'shoulda', path: '../../..'"
  steps %{And I run `bundle install --local`}

  append_to 'test/test_helper.rb', <<-TEXT
    Shoulda::Matchers.configure do |config|
      config.integrate do |with|
        with.test_framework :minitest
        with.library :rails
      end
    end
  TEXT
end

When 'I configure a wildcard route' do
  steps %{
    When I write to "config/routes.rb" with:
    """
    Rails.application.routes.draw do
      get ':controller(/:action(/:id(.:format)))'
    end
    """
  }
end

When 'I successfully run the "test" task' do
  steps %{
    When I successfully run `bundle exec rake test TESTOPTS='-v' --trace`
  }
end

Then /^the output should indicate that (\d+) tests were run successfully$/ do |number|
  if rails_gte_4_1?
    steps %{
      Then the output should contain:
      """
      #{number} runs, #{number} assertions, 0 failures, 0 errors
      """
    }
  else
    steps %{
      Then the output should contain:
      """
      #{number} tests, #{number} assertions, 0 failures, 0 errors
      """
    }
  end
end
