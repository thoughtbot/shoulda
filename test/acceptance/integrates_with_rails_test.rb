require 'acceptance_test_helper'

class ShouldaIntegratesWithRailsTest < AcceptanceTest
  def test_expectations
    create_rails_application_with_shoulda

    write_file 'db/migrate/1_create_users.rb', <<-FILE
      class CreateUsers < ActiveRecord::Migration
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
    FILE

    run_migrations

    write_file 'app/models/user.rb', <<-FILE
      class User < ActiveRecord::Base
        validates_presence_of :name
      end
    FILE

    write_file 'app/controllers/examples_controller.rb', <<-FILE
      class ExamplesController < ApplicationController
        before_action :some_before_action
        after_action :some_after_action
        around_action :some_around_action

        rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found

        layout "application"

        def index
          render :index
          head :ok
        end

        def create
          create_params
          flash[:success] = "Example created"
          session[:some_key] = "some value"
          redirect_to action: :index
        end

        def handle_not_found
        end

        private

        def some_before_action
        end

        def some_after_action
        end

        def some_around_action
          yield
        end

        def create_params
          params.require(:user).permit(:email, :password)
        end
      end
    FILE

    write_file 'app/views/examples/index.html.erb', <<-FILE
      Some content here
    FILE

    write_file 'config/routes.rb', <<-FILE
      Rails.application.routes.draw do
        resources :examples, only: [:index, :create]
      end
    FILE

    write_file 'test/models/user_test.rb', <<-FILE
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        should validate_presence_of(:name)
      end
    FILE

    write_file 'test/controllers/examples_controller_test.rb', <<-FILE
      require 'test_helper'

      class ExamplesControllerTest < ActionController::TestCase
        context "GET #index" do
          setup do
            get :index
          end

          should use_before_action(:some_before_action)
          should_not use_before_action(:some_other_before_action)
          should use_after_action(:some_after_action)
          should_not use_after_action(:some_other_after_action)
          should use_around_action(:some_around_action)
          should_not use_around_action(:some_other_around_action)

          should filter_param(:password)
          should_not filter_param(:some_other_param)

          should rescue_from(ActiveRecord::RecordNotFound).
            with(:handle_not_found)

          should render_template(:index)
          should_not render_template(:some_other_action)

          should render_with_layout("application")
          should_not render_with_layout("some_other_layout")

          should respond_with(:ok)
          should_not respond_with(:some_other_status)

          should route(:get, "/examples").to(action: :index)
          should_not route(:get, "/examples").to(action: :something_else)
        end

        context "POST #create" do
          should "permit correct params" do
            user_params = {
              user: {
                email: "some@email.com",
                password: "somepassword"
              }
            }
            positive_matcher = permit(:email, :password).
              for(:create, params: user_params).
              on(:user)
            negative_matcher = permit(:foo, :bar).
              for(:create, params: user_params).
              on(:user)
            assert_accepts positive_matcher, subject
            assert_rejects negative_matcher, subject
          end

          context "inner context" do
            setup do
              user_params = {
                user: {
                  email: "some@email.com",
                  password: "somepassword"
                }
              }
              post :create, user_params
            end

            should redirect_to("/examples")
            should_not redirect_to("/something_else")

            should set_flash[:success].to("Example created")
            should_not set_flash[:success].to("Something else")

            should set_session[:some_key].to("some value")
            should_not set_session[:some_key].to("some other value")
          end
        end
      end
    FILE

    result = run_n_unit_test_suite

    assert_accepts indicate_that_tests_were_run(failures: 0), result
  end

  def xtest_failing_expectations
    create_rails_application_with_shoulda

    write_file 'db/migrate/1_create_users.rb', <<-FILE
      class CreateUsers < ActiveRecord::Migration
        def self.up
          create_table :users do |t|
            t.string :name
          end
        end
      end
    FILE

    run_migrations

    write_file 'app/models/user.rb', <<-FILE
      class User < ActiveRecord::Base
      end
    FILE

    write_file 'test/unit/user_test.rb', <<-FILE
      require 'test_helper'

      class UserTest < ActiveSupport::TestCase
        should validate_presence_of(:name)
      end
    FILE

    result = run_n_unit_test_suite

    assert_accepts indicate_that_tests_were_run(unit: 1, functional: 1), result
  end

  private

  def create_rails_application_with_shoulda
    create_rails_application

    updating_bundle do |bundle|
      add_shoulda_to_project(
        test_frameworks: [:minitest],
        libraries: [:rails],
      )
    end
  end

  def run_migrations
    run_rake_tasks!(['db:drop', 'db:create', 'db:migrate'])
  end
end
