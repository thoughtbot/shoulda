require 'acceptance_test_helper'

class ShouldaIntegratesWithRailsTest < AcceptanceTest
  def test_works_in_a_project_that_uses_minitest
    create_rails_application

    write_file 'db/migrate/1_create_users.rb', <<-FILE
      class CreateUsers < ActiveRecord::Migration
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
    FILE

    run_rake_tasks!(['db:drop', 'db:create', 'db:migrate'])

    write_file 'app/models/user.rb', <<-FILE
      class User < ActiveRecord::Base
        validates_presence_of :name
      end
    FILE

    write_file 'app/controllers/examples_controller.rb', <<-FILE
      class ExamplesController < ApplicationController
        def index
          @example = 'hello'
          render nothing: true
        end
      end
    FILE

    write_file 'config/routes.rb', <<-FILE
      Rails.application.routes.draw do
        resources :examples, only: [:index]
      end
    FILE

    updating_bundle do
      add_shoulda_to_project(
        test_frameworks: [:minitest],
        libraries: [:rails],
      )
    end

    write_file 'test/unit/user_test.rb', <<-FILE
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        should validate_presence_of(:name)
      end
    FILE

    write_file 'test/functional/examples_controller_test.rb', <<-FILE
      require 'test_helper'

      class ExamplesControllerTest < ActionController::TestCase
        def setup
          get :index
        end

        should respond_with(:success)
      end
    FILE

    result = run_n_unit_test_suite

    assert_accepts indicate_that_tests_were_run(unit: 1, functional: 1), result
    assert_accepts(
      have_output('User should validate that :name cannot be empty/falsy'),
      result,
    )
    assert_accepts have_output('should respond with 200'), result
  end
end
