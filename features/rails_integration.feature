Feature: Integrate with Rails

  Background:
    When I generate a new Rails application
    And I write to "db/migrate/1_create_users.rb" with:
      """
      class CreateUsers < ActiveRecord::Migration
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
      """
    When I successfully run `bundle exec rake db:migrate --trace`
    And I write to "app/models/user.rb" with:
      """
      class User < ActiveRecord::Base
        validates_presence_of :name
      end
      """
    When I write to "app/controllers/examples_controller.rb" with:
      """
      class ExamplesController < ApplicationController
        def show
          flash['foo'] = 'bar'
          render :nothing => true
        end
      end
      """
    When I configure a wildcard route

  Scenario: Generate a Rails application and use matchers under Minitest
    When I configure the application to use Shoulda
    And I write to "test/models/user_test.rb" with:
      """
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        should validate_presence_of(:name)
      end
      """
    When I write to "test/controllers/examples_controller_test.rb" with:
      """
      require 'test_helper'

      class ExamplesControllerTest < ActionController::TestCase
        def setup
          get :show
        end

        should set_flash[:foo].to('bar')
        should respond_with(:success)
      end
      """
    When I successfully run the "test" task
    Then the output should contain:
      """
      ExamplesController should respond with 200.
      """
    And the output should contain:
      """
      ExamplesController should should set flash[:foo] to "bar".
      """
    And the output should contain:
      """
      User should validate that :name cannot be empty/falsy.
      """
    And the output should indicate that 3 tests were run successfully
