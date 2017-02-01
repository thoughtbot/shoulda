require 'acceptance_spec_helper'

describe 'Shoulda integrates with Rails' do
  before do
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

    run_rake_tasks!(["db:drop", "db:create", "db:migrate"])

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
  end

  specify 'in a project that uses Minitest' do
    updating_bundle do
      add_gems_for_n_unit
      add_shoulda_to_project(
        test_frameworks: [:minitest],
        libraries: [:rails],
      )
    end

    run_tests_for_n_unit
  end

  def add_gems_for_n_unit
    add_gem 'shoulda-context'
  end

  def run_tests_for_n_unit
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

    expect(result).to indicate_that_tests_were_run(unit: 1, functional: 1)
    expect(result).to have_output(
      'User should validate that :name cannot be empty/falsy',
    )
    expect(result).to have_output('should respond with 200')
  end
end
