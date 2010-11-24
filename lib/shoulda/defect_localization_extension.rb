#
# 1 class PersonsControllerTest < ActionController::TestCase
# 2
# 3   context "on get :show" do
# 4     setup do
# 5       @person = Person.first
# 6       get :show, :id => @person.id
# 7     end
# 8
# 9     should respond_with :success
#10   end
#11 end
#
#
#1) Failure:
#test: on get :show should respond with :success. (PersonsControllerTest)
#[DEFECT:1
#     /test/functional/persons_controller_test.rb:9:in `__bind_1290606365_660643'
#
#
#SHOULD_BACKTRACE:2
#/test/functional/blog/tags_controller_test.rb:9:in `__bind_1290606365_660643'
#shoulda (2.11.3) lib/shoulda/context.rb:306:in `call'
#shoulda (2.11.3) lib/shoulda/context.rb:306:in `merge_block'
#shoulda (2.11.3) lib/shoulda/context.rb:301:in `initialize'
#shoulda (2.11.3) lib/shoulda/context.rb:199:in `new'
#shoulda (2.11.3) lib/shoulda/context.rb:199:in `context'
#/test/functional/persons_controller_test.rb:3
#...
#-e:1
#-e:1:in `each'
#-e:1
#
#
#ASSERTION_BACKTRACE:3
#shoulda (2.11.3) lib/shoulda/assertions.rb:59:in `assert_accepts'
#shoulda (2.11.3) lib/shoulda/context.rb:382:in `call'
#shoulda (2.11.3) lib/shoulda/context.rb:382:in `test: on get :show should respond with :success. '
#activesupport (2.3.10) lib/active_support/testing/setup_and_teardown.rb:62:in `__send__'
#activesupport (2.3.10) lib/active_support/testing/setup_and_teardown.rb:62:in `run'
#response to be a 200, but was 303

module Shoulda
  module DefectLocalizationExtension
    def assert_block(*args)
      begin
        super
      rescue Test::Unit::AssertionFailedError => exception
        set_backtrace_for_exception(exception)
        raise exception
      end
    end

    private
    def set_backtrace_for_exception(exception)
      if @shoulda_backtrace
        backtrace = [extract_shoulda_assertion(exception),
          extract_complete_shoulda_backtrace,
          extract_complete_assertion_backtrace(exception)].flatten.compact

        exception.set_backtrace(backtrace)
      end
    end

    def extract_shoulda_assertion(exception)
      backtrace = @shoulda_backtrace + exception.backtrace
      backtrace = backtrace.grep(/#{self.class.to_s.underscore}\.rb\:[0-9]*/)
      backtrace = backtrace.sort_by {|code_line| code_line.match(/\.rb\:([0-9]*)/)[1].to_i}.reverse

      assertion ||= backtrace.detect do |code_line|
        code_line.match(/#{self.class.to_s.underscore}\.rb\:[0-9]*/)
      end

      ["DEFECT:1", assertion, '']
    end

    def extract_complete_shoulda_backtrace
      ["SHOULD_BACKTRACE:2", @shoulda_backtrace, '']
    end

    def extract_complete_assertion_backtrace(exception)
      ["ASSERTION_BACKTRACE:3", exception.backtrace]
    end
  end
end